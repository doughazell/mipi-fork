class PresentationsController < ApplicationController
  
  def index
    @globe = Globe.find(params[:globe_id])

    @presentations = []
    
    @profiles = @globe.profiles
    @profiles.each do |profile|
      profile.data_sheets.each do |data_sheet|
        data_sheet.presentations.each do |presentation|
          @presentations.push  presentation
        end
      end
    end
    
    @presentations.sort! {|a,b| a.data_sheet.name <=> b.data_sheet.name }
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @presentations }
    end
  end
  
  def show
    @globe = Globe.find(params[:globe_id])
    @presentation = Presentation.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @presentation }
    end
   
  end
  
  def edit
    @globe = Globe.find(params[:globe_id])
    @presentation = Presentation.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def new
    @globe = Globe.find(params[:globe_id])
    @presentation = Presentation.new
    @data_sheets = []
    
    @globe.profiles.each do |profile|
      profile.data_sheets.each do |data_sheet|
        @data_sheets.push data_sheet
      end
    end
    
    @data_element_types =[]
    @data_element_collections = DataElementCollection.find_all_by_globe_id(@globe.id)
    
    @data_element_collections.each do |data_element_collection|
      @data_element_types.push data_element_collection.data_element_type
    end
    
    @data_element_types.uniq!
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @presentation }
    end

  end
  
  def create
    @globe = Globe.find(params[:globe_id])
    @presentation = Presentation.new(params[:presentation])
    @data_sheets = []
    
    @globe.profiles.each do |profile|
      profile.data_sheets.each do |data_sheet|
        @data_sheets.push data_sheet
      end
    end
    
    @data_element_types =[]
    @data_element_collections = DataElementCollection.find_all_by_globe_id(@globe.id)
    
    @data_element_collections.each do |data_element_collection|
      @data_element_types.push data_element_collection.data_element_type
    end
    
    @data_element_types.uniq!
    

    respond_to do |format|
      if @presentation.save
        format.html { redirect_to([@globe, @presentation], :notice => 'Globe was successfully created.') }
        format.xml  { render :xml => @presentation, :status => :created, :location => @presentation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @presentation.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @globe = Globe.find(params[:globe_id])
    @presentation = Presentation.find(params[:id])
    
    @presentation.destroy

    respond_to do |format|
      format.html { redirect_to(globe_presentations_url) }
      format.xml  { head :ok }
    end
  end
end
