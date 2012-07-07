# The globe controller will provide the overview of the 'account' being accessed by the
# current user.
class GlobesController < ApplicationController
  include GlobesHelper

#  before_filter :authenticate_user!, :except => [:index]
  before_filter :authenticate_user!
#  before_filter :require_user
  before_filter :set_current_user
  
  # GET /globes
  # GET /globes.xml
  def index
    @registrations = Registration.viewable(current_user)
    @ids = Array.new
    @registrations.each do |r|
      logger.info("Globe ID: #{r.globe_id}")
      @ids.push(r.globe_id)
    end
    @globes = Globe.top_level.find_all_by_id(@ids)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @globes }
    end
  end

  # GET /globes/1
  # GET /globes/1.xml
  def show
#    @globe = Globe.find(params[:id])
#    @globe = Globe.find_by_globe_reference!(request.subdomain)

    # We may be at rfu.piguard.com. Therefore, subdomain retains the globe of 'rfu'.
    @masterglobe = Globe.find_by_globe_reference!(request.subdomain)
    
    # We may receive a specific request to see a globe (most likely a shadow globe)
    # that represents a different 'party'.
    if params[:id] 
      @globe = Globe.find(params[:id])
    else
      @globe = @masterglobe
    end
    
    # Check to see if these are different. If they are we may need to gather some
    # more information about the particular shadow globe.
    if @globe.id != @masterglobe.id
      # Just check that this is a parent-child relationship.
      if @globe.parent_id == @masterglobe.id
        @parentglobe = @masterglobe
      end
    else # Cache this children anyway, in order to list them.
      @shadowglobes = @globe.children
    end
    
#    @profiles = Profile.find_all_by_globe_id(@globe.id)   # TODO: Review - should this be @globe.profiles
    @profiles = @globe.profiles
    
    #respond_to do |format|
    #  format.html { redirect_to(preview_globe_path(@globe), :notice => 'Welcome to the Globe') }
    #end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @globe }
    end
  end

  # GET /globes/new
  # GET /globes/new.xml
  def new
    @globe = Globe.new
    @users = User.find(:all)
    profile = @globe.profiles.build
    data_sheet = profile.data_sheets.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @globe }
    end
  end

  # GET /globes/1/edit
  def edit
    @globe = Globe.find(params[:id])
#    @users = User.find(:all)
  end

  # POST /globes
  # POST /globes.xml
  def create
    @globe = Globe.new(params[:globe])
#    @users = User.find(:all)

    reg = Registration.new :globe => @globe, :user => current_user
    reg.save
    
    @globe.profiles.each do |profile|
      profile.setup_defaults(@globe)
    end

#    create_localhost_entry(@globe.globe_reference)

    respond_to do |format|
      if @globe.save
        format.html { redirect_to(@globe, :notice => 'Globe was successfully created.') }
        format.xml  { render :xml => @globe, :status => :created, :location => @globe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @globe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /globes/1
  # PUT /globes/1.xml
  def update
    @globe = Globe.find(params[:id])

    respond_to do |format|
      if @globe.update_attributes(params[:globe])
        format.html { redirect_to(@globe, :notice => 'Globe was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @globe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /globes/1
  # DELETE /globes/1.xml
  def destroy
    @globe = Globe.find(params[:id])
    @globe.destroy

    respond_to do |format|
      format.html { redirect_to(globes_url) }
      format.xml  { head :ok }
    end
  end
  
  def preview
    @masterglobe = Globe.find_by_globe_reference!(request.subdomain)
    @globe = current_user.globes.find(params[:id])
    @shadowglobes = @globe.children # .sort! { |a,b| a.name.downcase <=> b.name.downcase }
#    @globe = Globe.find(params[:id])
    @profiles = @globe.profiles(:order => 'position')
#    @profiles = @globe.profiles.sort! { |a,b| a.position <=> b.position }
    if params[:profile_id] then
      @active_profile = @profiles.find(params[:profile_id])
    else
      @active_profile = @profiles.find(:first)
    end
    @profiles.sort! { |a,b| a.position <=> b.position }
    
    if @active_profile then
      @data_sheets = @active_profile.data_sheets
      @data_sheets.sort! {|a,b| a.name <=> b.name}
      if (params[:data_sheet_id]) then
        @active_data_sheet = @data_sheets.find(params[:data_sheet_id])
      else
        @active_data_sheet = @data_sheets.find(:first)
      end
    end
    
  end
end
