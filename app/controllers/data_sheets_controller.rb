# @author Paul Long
# This controller handles the rendering of the main page containing
# the one or more data elements retrieved through the data model.
# The two major methods that are triggered by end-user activity are:
# 'preview' and 'change'.
class DataSheetsController < ApplicationController
#  require 'test'
  include DataSheetsHelper
  before_filter :authenticate_user!

  # GET /data_sheets
  # GET /data_sheets.xml
  def index
    @profile = Profile.find(params[:profile_id])
    @globe = @profile.globe
    @data_sheets = DataSheet.find_all_by_profile_id(@profile.id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @data_sheets }
    end
  end

  # GET /data_sheets/1
  # GET /data_sheets/1.xml
  def show
    @data_sheet = DataSheet.find(params[:id])
    @profile = @data_sheet.profile
    @globe = @profile.globe

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @data_sheet }
    end
  end

  # GET /data_sheets/new
  # GET /data_sheets/new.xml
  def new
    puts params.inspect
    @data_sheet = DataSheet.new
    if !params[:profile_id].blank? then
      @profile = Profile.find(params[:profile_id])
      @globe = @profile.globe
    end

    puts "-000-"
    puts @profile
    puts @globe
    puts @data_sheet

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @data_sheet }
    end
  end

  # GET /data_sheets/1/edit
  def edit
    @data_sheet = DataSheet.find(params[:id])
    @profile = @data_sheet.profile
    @globe = @profile.globe
  end

  # POST /data_sheets
  # POST /data_sheets.xml
  def create
    @data_sheet = DataSheet.new(params[:data_sheet])
    @data_sheet.profile_id = params[:profile_id]

    respond_to do |format|
      if @data_sheet.save
        format.html { redirect_to(globe_profile_data_sheets_url, :notice => 'Data sheet was successfully created.') }
        format.xml  { render :xml => @data_sheet, :status => :created, :location => @data_sheet }
      else
        puts "Redirecting to 'New' action"
        format.html { redirect_to :action => "new", :notice => "Invalid parameters for Data Sheet" }
        format.xml  { render :xml => @data_sheet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /data_sheets/1
  # PUT /data_sheets/1.xml
  def update
    @data_sheet = DataSheet.find(params[:id])
    @profile = @data_sheet.profile
    @globe = @profile.globe

    respond_to do |format|
      if @data_sheet.update_attributes(params[:data_sheet])
        format.html { redirect_to(globe_profile_data_sheet_url, :notice => 'Data sheet was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @data_sheet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /data_sheets/1
  # DELETE /data_sheets/1.xml
  def destroy
    @data_sheet = DataSheet.find(params[:id])
    @data_sheet.destroy

    respond_to do |format|
      format.html { redirect_to(globe_profile_data_sheets_url) }
      format.xml  { head :ok }
    end
  end

  # 'Preview' is our bland look at how the data can be represented.
  # @todo Class Method Calls
  #   Review to see if we should be making class method calls to 'Profile' and 'DataSheet'
  #   or whether these should be exchanged for instance methods.
  def preview
    @masterglobe = Globe.find_by_globe_reference!(request.subdomain)
    if current_user.globes.blank? == true then
      @globe = @masterglobe
    else
      # 25-Mar-2013/PL - the globe_id is rarely passed as the param: 'id'
      # it is usually explicitly 'globe_id'
      @globe = current_user.globes.find(params[:globe_id] || params[:id])
#      @globe = current_user.globes.find(params[:id])
    end
    
    @shadowglobes = @globe.children # .sort! { |a,b| a.name.downcase <=> b.name.downcase }
    
#    @globe = Globe.find(params[:globe_id])
    # Updated logic to prevent the returning of nil as a comparison result.
    #                                                       13-May-2013/PL
    @profiles = @globe.profiles.sort! { |a,b| (a.position <=> b.position).nil? ? 1 : a.position <=> b.position }
    @active_profile = Profile.find(params[:profile_id])
    @data_sheets = @active_profile.data_sheets
    @data_sheets.sort! {|a,b| a.name <=> b.name}
    @active_data_sheet = DataSheet.find(params[:id])
    
    # Retrieve all the database data required.
    calculate_data_sheet_elements(@active_data_sheet)
    
    # Create a new instance to facilitate...
#    @profile = Profile.new
    
  end

  # Within this method we must pull the database information back the collection
  # of database objects that are associated with this data sheet.
  # In fact, we need to pull the information based on the "Profile". 
  def draw
    
    # Identify the Data Sheet that we wish to display. This will be rendered within the
    # respond_to block further down.
    @data_sheet = DataSheet.find(params[:id])
    
    calculate_data_sheet_elements(@data_sheet)
    _draw(@data_sheet)
    #DataSheetsHelper _draw(@data_sheet)
  end
  
  def _draw(data_sheet)

    template = Liquid::Template.parse("{{source_value}} {{destination_value}}")
    @text = template.render('source_value' => 'pop', 'destination_value' => 'corn')
    puts "test test test test test test test test test test test test test test test test"
    
    respond_to do |format|
      # Render the data into the pre-defined .html.erb file stored within:
      #         'views/data_sheets/pages/'
#      format.html { render @data_sheet.file_location }
      format.html { render :partial => @data_sheet.file_location }
       format.xml  { render :xml => @data_sheet }
    end
   
  end

  # This method identifies the data model objects that will be required to support the
  # data sheet that has been passed as a parameter. A special 'variable' will be defined
  # dynamically that will allow the 'Page' to render the data within the partial associated
  # with this data sheet.
  # @param data_sheet The data sheet of which we need to collate the appropriate data model elements.
  def calculate_data_sheet_elements(data_sheet)
    @list_of_collections = Array.new
    @globe_id = data_sheet.profile.globe_id
    @custom_stylesheet = data_sheet.style_sheets

    # This has been included because we found the data model was not being loaded all the
    # time. The exact cause of this has not been identified.
#    puts DataElement.all.count                        # TODO: Research Bug
    
    # Retrieve the data rows from the link table 'presentations' that will tell
    # us what data collections should be pulled back for this sheet.
    @outputs = Presentation.find_all_by_data_sheet_id(data_sheet.id)
    
    if @outputs.count == 0 then
      respond_to do |format|
#        format.html { render :partial => 'data_sheets/pages/missing_presentation', :notice => "Error: Missing Presentation Data" }
        format.html { redirect_to preview_globe_url(@globe), :notice => "Error: Missing Presentation Data" }
      end
    else
    
      hash_of_variables = Hash.new
      
      @outputs.each do |sheet_part|
        @part = DataElementCollection.find(sheet_part.data_element_collection_id)
#        puts @part.inspect
#        puts "-----"
        if hash_of_variables.has_key? @part.variable_name then
          hash_of_variables[@part.variable_name] = hash_of_variables[@part.variable_name] + 1
        else
          hash_of_variables[@part.variable_name] = 1
          hash_of_variables[@part.variable_name + "_offset"] = 0
        end
      end
      
#      puts hash_of_variables.to_s
      hash_of_variables.each { |key,value|
#        puts "#{key} is #{value}"
        if value > 1 then
#          puts "Creating array for #{key}"
          instance_variable_set("#{key}_array", Array.new)
        end
      }
      
      # For each of these data rows there shall be a data collection row to retrieve
      # and resolve.
      @outputs.each do |sheet_part|
  
        # Grab the data element collection.
        @part = DataElementCollection.find(sheet_part.data_element_collection_id)
        
        if @part.historic? then
          # For historical data sets, such as bank transactions; twitter feeds; etc. we need to
          # carry out a 'find all' and carry out pagination.
#          instance_variable_set("#{@part.variable_name}", eval(@part.data_element_type).find_all_by_data_element_collection_id_and_globe_id(@part.id, @globe_id, :order => @part.order_by_column).paginate(:page => params[:page], :per_page => @part.page_limit))
          instance_variable_set("#{@part.variable_name}", eval(@part.data_element_type).find_all_by_data_element_collection_id_and_globe_id(@part.id, @globe_id, :order => @part.order_by_column))
        else
          # For non-historic data sets, e.g. personal data; statuses; overdraft limits; etc. we
          # only need to retrieve one record.
          if (hash_of_variables[@part.variable_name] == 1)
            puts @part.inspect
            puts @globe_id
#            instance_variable_set("#{@part.variable_name}", eval(@part.data_element_type).find(:first, :conditions => { :data_element_collection_id => @part.id, :globe_id => @globe_id }, :order => "version DESC"))
#            instance_variable_set("#{@part.variable_name}", @part.data_element_type.constantize.find(:first, :conditions => { :data_element_collection_id => @part.id, :globe_id => @globe_id }, :order => "version DESC"))
            instance_variable_set("#{@part.variable_name}", @part.data_element_type.constantize.find(:first, :conditions => { :data_element_collection_id => @part.id, :globe_id => @globe_id, :current => true }))
          else
            offset = hash_of_variables["#{@part.variable_name}_offset"]
#            instance_variable_set("@tmp", eval(@part.data_element_type).find_by_data_element_collection_id_and_globe_id(@part.id, @globe_id, :order => "created_at DESC"))
#            instance_variable_set("@tmp", @part.data_element_type.constantize.find_by_data_element_collection_id_and_globe_id(@part.id, @globe_id, :order => "created_at DESC"))
            instance_variable_set("@tmp", @part.data_element_type.constantize.find(:first, :conditions => { :data_element_collection_id => @part.id, :globe_id => @globe_id, :current => true }))
            if (!@tmp.nil?)
              hash_of_variables["#{@part.variable_name}_offset"] = hash_of_variables["#{@part.variable_name}_offset"] + 1
              instance_variable_set("#{@part.variable_name}_array", eval("#{@part.variable_name}_array + [@tmp]"))
            end
#            instance_variable_set("#{@part.variable_name}_array", eval("#{@part.variable_name}_array + [@tmp]").paginate(:page => params[:page], :per_page => @part.data_element_type.constantize::DEFAULT_PAGE_LIMIT))
          end
        end
        
        # Build up list of 'variable' names. Here we're removing the leading '@' sign.
        @list_of_collections << @part.variable_name[1, @part.variable_name.length - 1]
      end
      
      # Debug
      puts @list_of_collections.join("\n")
    end    
  end

  def change
#    @data_elements = Array.new
    @data_elements = params['data_element_collections'].split(',')
    @data_sheet = DataSheet.find(params[:id])
    @profile = Profile.find(params[:profile_id])
    @globe = Globe.find(params[:globe_id])

    @data_elements.each do |data_element_name|
      records = params[data_element_name]
      if (records)
        records.each do |id, values|
          
          # Locate the current data element that has faithfully represented our
          # data up until now.
          @data_element = DataElement.find(id)
          puts @data_element.inspect
          
          # Construct a new blank data element. This will take a complete copy
          # of @data_element in order to retain a historical representation.
#          @retain_data_element = eval("#{@data_element.type}.new(@data_element.attributes)")
          @retain_data_element = @data_element.type.constantize.new(@data_element.attributes.except!("id"))
          puts @retain_data_element.inspect

          # Loop through all the key, value pairs and update the data_element to ensure
          # the correct new values are applied.
          values.each do |column, value|
            puts ">> #{data_element_name} == #{id}: '#{column}' assign to '#{value}'"
            eval("@data_element.#{column} = '#{value}'")
          end
          
          # Ensure appropriate versioning is applied to distinguish the latest version.
          if @retain_data_element.version.nil? then
            @retain_data_element.version = 0
          end if
          
#          @data_element.version = @retain_data_element.version + 1
          # Working around version being nil and trying to add an
          # integer to this. Time.now.to_i could be a better overall
          # solution anyway. Individual integers going up from 0
          # was more human readable though.
          @data_element.version = Time.now.to_i
          @data_element.updated_at = Time.now

          # Ensure the new data_element is current.
          @retain_data_element.current = false
          @data_element.current = true

#          @data_element.update_elements(@retain_data_element, values)
          # Write back to the database.
          @data_element.save
          @retain_data_element.save
        end
      end
    end

    respond_to do |format|
#      if @data_element.update_attributes(params[:data_element])
        format.html { redirect_to(preview_globe_profile_data_sheet_path(@globe, @profile, @data_sheet), :notice => 'Data was successfully updated.') }
#        format.html { redirect_to(@data_element, :notice => 'Data was successfully updated.') }
        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @data_element.errors, :status => :unprocessable_entity }
#      end
    end
  end

  def editable(data_element, database_column, id)
    html = render :partial => 'editable', :locals => { :data_element => data_element,
                                                            :database_column => database_column,
                                                            :id => id }
    html[0]
  end
  
  def new_data_element
    @globe = Globe.find(params[:globe_id])
    @profile = Profile.find(params[:profile_id])
    @data_sheet = DataSheet.find(params[:id])

    # Determine the class name, create a new instance of it.    
    @class_name = params[:data_element_collection_name]
    instance_variable_set(@class_name.constantize::DEFAULT_VARIABLE_NAME, @class_name.constantize.new)
    
    # Use the short underscore name by convention: e.g. data_domain, rather than data_domain_data_element
    class_name_short = @class_name.constantize.short_undescore_name
    
    # Optionally override the partial we are going to render.
    @partial_name = params[:partial]
    @partial_name = "/data_sheets/pages/#{@globe.globe_reference}/#{class_name_short}/new.html.erb" if @partial.nil?
    
    # By default the DIV will be: new_data_element_content but you can override this.
    @div_content = params[:div_content]
    @div_content = "new_data_element_content" if @div_content.nil?
    
    # Text to display for minimise button.
    @button_text = params[:close_button_text]
    @button_text = "New #{@class_name.constantize.frendly_class_name} <<" if @button_text.nil?
    # new_data_element.js.erb called by default
  end

  def change_data_element
    @globe = Globe.find(params[:globe_id])
    @profile = Profile.find(params[:profile_id])
    @data_sheet = DataSheet.find(params[:data_sheet_id])
  end
    
  def create_data_element
    @globe = Globe.find(params[:globe_id])
    @profile = Profile.find(params[:profile_id])
    @data_sheet = DataSheet.find(params[:id])
    class_name = params[:class_name]
    
    # Create the collection that will hold the history of this data type.
    dec = DataElementCollection.new(:name => params[:data][:name],
                              :data_element_type => class_name,
                              :variable_name => class_name.constantize::DEFAULT_VARIABLE_NAME,
                              :globe_id => @globe.id,
                              :page_limit => 1,
                              :historic => false)
    
    dec.save

    # Create an instance of the DataElement-derived class we wish to maintain.
    de = class_name.constantize.new(params[:data])
    
    # ...and populate it.
    de.data_element_collection_id = dec.id
    de.user_id = current_user.id
    de.globe_id = @globe.id
    de.version = 0
    de.current = true
    
    de.save
    
    # Now, should we associate this new element with any DataSheets? This is
    # achieved through Presentations. The relationship is between a DataSheet
    # and a DataElementCollection. Let's locate the DataSheet
    ds_names = params[:default_data_sheet_links]
    
    # Of course, only if we've been told that there are some default DataSheets
    # that we need to accommodate for.
    if !ds_names.nil? then
      ds = DataSheet.find_by_name_and_profile_id(ds_names, @profile.id)
      if !ds.nil?
        pres = Presentation.find_or_initialize_by_data_sheet_id_and_data_element_collection_id(ds.id, dec.id)
        pres.save
      end
    end
   
    # Should we create a default DataSheet and link to that? Each model may have
    # specific values set within it as default. This should really be meta-data.
    if class_name.constantize::DEFAULT_DATA_SHEET.present?
      dds = class_name.constantize::DEFAULT_DATA_SHEET
      ds = DataSheet.new(:name => params[:data][:name],
                         :display_name => params[:data][:name],
                         :style_sheets => dds[:style_sheet],
                         :profile_id => @profile.id,
                         :file_location => dds[:file_location]
                         )
      ds.save
      pres = Presentation.find_or_initialize_by_data_sheet_id_and_data_element_collection_id(ds.id, dec.id)
      pres.save
    end
    
    respond_to do |format|
      format.html { redirect_to(preview_globe_profile_data_sheet_path) }
      format.xml  { head :ok }
    end
  end
  
end