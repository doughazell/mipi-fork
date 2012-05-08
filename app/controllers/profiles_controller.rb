class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /profiles
  # GET /profiles.xml
  def index
#    @profiles = Profile.all
    @globes = Globe.find(params[:globe_id])
    @profiles = @globes.profiles.find(:all, :order => "created_at DESC", :include => [:globe])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.xml
  def show
    @globe = Globe.find(params[:globe_id])
    @profile = Profile.find(params[:id])
    @globe = @profile.globe
    @data_sheets = DataSheet.find_all_by_profile_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.xml
  def new
    @globe = Globe.find(params[:globe_id])
    @profile = @globe.profiles.build
    data_sheet = @profile.data_sheets.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @globe = Globe.find(params[:globe_id])
    @profile = @globe.profiles.find(params[:id])
  end

  # POST /profiles
  # POST /profiles.xml
  def create
    @globe = Globe.find(params[:globe_id])
    @profile = Profile.new(params[:profile])
    puts @profile.inspect
    @profile.globe_id = @globe.id
    puts "Profile: Create"
    
    @profile.setup_defaults(@globe)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to([@globe, @profile], :notice => 'Profile was successfully created.') }
        format.xml  { render :xml => @profile, :status => :created, :location => @profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @globes = Globe.find(params[:globe_id])
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
#        format.html { redirect_to(@profile, :notice => 'Profile was successfully updated.') }
        format.html { redirect_to(globe_profile_url, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.xml
  def destroy
    @globes = Globe.find(params[:globe_id])
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to(globe_profiles_url) }
      format.xml  { head :ok }
    end
  end

  def preview
    @masterglobe = Globe.find_by_globe_reference!(request.subdomain)
    @globe = current_user.globes.find(params[:globe_id])
    @shadowglobes = @globe.children
#    @globe = Globe.find(params[:globe_id])
    @profiles = @globe.profiles
#    @profiles = @globe.profiles.sort! { |a,b| a.position <=> b.position }
    @active_profile = @profiles.find(params[:id])
    @profiles.sort! { |a,b| a.position <=> b.position }
    
    if @active_profile then
      @data_sheets = @active_profile.data_sheets
      if (params[:data_sheet_id]) then
        @active_data_sheet = @data_sheets.find(params[:data_sheet_id])
      else
        @active_data_sheet = @data_sheets[0]
      end
      respond_to do |format|
        format.html { redirect_to(preview_globe_profile_data_sheet_path(@globe, @active_profile, @active_data_sheet )) }
#      DataSheetsController.calculate_data_sheet_elements(@active_data_sheet)
      end
    end
  end
  
  def sort
    @globe = current_user.globes.find(params[:globe_id])
    params[:preview_profiles].each_with_index do |id, index|
      @globe.profiles.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
end
