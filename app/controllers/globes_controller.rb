# The globe controller will provide the overview of the 'account' being accessed by the
# current user.
class GlobesController < ApplicationController
  include GlobesHelper

#  before_filter :authenticate_user!, :except => [:index]
  before_filter :authenticate_user!
#  before_filter :authenticate_user!, except: [:index, :show]
#  before_filter :require_user
  before_filter :set_current_user
  
  # ------------------------------------------------------------------------------------
  # 26/7/13 DH: Passing values via class variables didn't work between rails sessions...
  @@invalidSubdomain = "WTF???"
  
  def self.invalidSubdomain?
    @@invalidSubdomain
  end
  
  def self.invalidSubdomain=(string)
    puts "Setting class variable 'invalidSubdomain' to: " + string
    @@invalidSubdomain = string
  end
  # ------------------------------------------------------------------------------------


  
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
    
    # 24/7/13 DH: To accomodate an invalid subdomain we don't want the ActiveRecord 
    #            dynamic attribute-based finder to return an 'ActiveRecord::RecordNotFound' error
    #            so the "!" has been removed from the end and the return checked for 'nil'. 
    @masterglobe = Globe.find_by_globe_reference(request.subdomain)
    
    # We may receive a specific request to see a globe (most likely a shadow globe)
    # that represents a different 'party'.
    if params[:id] 
      
      # ----------------------------------------------------------------------------------
      puts "Find Globe ID: " + params[:id]
      if $invalidSubdomain
        puts "--------------------------------------------------------------------"
        puts "Accessing Globe ID after an initial request for an invalid subdomain"
        puts "--------------------------------------------------------------------"
        $invalidSubdomain = nil
        if $invalidSubdomain
          puts "Still set eh?"
        else
          puts "Just checking it had been reset!!!"
        end
      end
      # Now set the subdomain to the current globe reference...
      # ----------------------------------------------------------------------------------
      
      @globe = Globe.find(params[:id])
    else
      @globe = @masterglobe
    end
    
    # Check to see if these are different. If they are we may need to gather some
    # more information about the particular shadow globe.
    if @masterglobe && (@globe.id != @masterglobe.id)
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
#      format.xml  { render :xml => @globe }
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
    puts " Finding: " + request.subdomain
    # 24/7/13 DH: To accomodate an invalid subdomain we don't want the ActiveRecord 
    #            dynamic attribute-based finder to return an 'ActiveRecord::RecordNotFound' error
    #            so the "!" has been removed from the end and the return checked for 'nil'. 
    @masterglobe = Globe.find_by_globe_reference(request.subdomain)
    
    if @masterglobe.nil? then
      puts "Yea baby! No '" + request.subdomain + "' globe found!"
    end
    
    # Following the change to the route.rb file to match the blank
    # subdomain to globes#preview, we now need to not necessarily
    # expect a globe_id (passed as :id) to be specified.
    #                                             22-Apr-2013/PL
    if current_user.globes.blank? == true || params[:id].nil? then
      @globe = @masterglobe
      puts "No valid params to the URL so taking the globe purely from the subdomain!"
    else
      @globe = current_user.globes.find(params[:id])
    end
    
    # 25/7/13 DH: At this point if the requested subdomain is not a valid globe then @globe will be 'nil'!
    if @globe.nil? then
    
      # Change the subdomain to the IP of the server...
      puts "Requested subdomain: " + request.subdomain
      puts "Requested domain: " + request.domain
      puts "Request ip: " + request.ip
      puts "Request host with port: " + request.host_with_port
      puts "Request url: " + request.url
      
      ip = Socket.ip_address_list.last.ip_address
      
      newURL = "http://" + ip + ":" + request.port.to_s
      puts "New URL: " + newURL + "/globes"
      
      flash[:error] = "Requested subdomain is invalid!  Fucking get a life!!!"      
      #return redirect_to globes_path
      
      #return redirect_to(newURL(:invalidSubdomain => "Requested subdomain is invalid!  Fucking get a life!!!" ))
      
      GlobesController.invalidSubdomain = "Requested subdomain is invalid!  Fucking get a life!!!"
      $invalidSubdomain = Hash[:msg => "Requested subdomain is invalid!  Fucking get a life!!!"]
      $invalidSubdomain.merge!(:domain => request.domain)
      
      # Breaky, break, break Mr Hens...
      #$invalidSubdomain = nil
      
      #debugger
      
      return redirect_to newURL
    end
    
    @shadowglobes = @globe.children # .sort! { |a,b| a.name.downcase <=> b.name.downcase }
#    @globe = Globe.find(params[:id])
    @profiles = @globe.profiles(:order => 'position')
#    @profiles = @globe.profiles.sort! { |a,b| a.position <=> b.position }
    if params[:profile_id] then
      @active_profile = @profiles.find(params[:profile_id])
    else
      @active_profile = @profiles.find(:first)
    end
    if @profiles.count > 1 then
      # Updated logic to prevent the returning of nil as a comparison result.
      #                                                       13-May-2013/PL
      @profiles.sort! { |a,b| (a.position <=> b.position).nil? ? 1 : a.position <=> b.position }
    end
    
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
