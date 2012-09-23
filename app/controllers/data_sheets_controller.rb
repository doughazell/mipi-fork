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
    @data_sheet = DataSheet.new
    if !params[:profile_id].blank? then
      @profile = Profile.find(params[:profile_id])
      @globe = @profile.globe
    end

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
        format.html { render :action => "new" }
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
    @globe = current_user.globes.find(params[:globe_id])
    @shadowglobes = @globe.children
#    @globe = Globe.find(params[:globe_id])
    @profiles = @globe.profiles.sort! { |a,b| a.position <=> b.position }
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
        format.html { render :partial => 'data_sheets/pages/missing_presentation' }
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
          instance_variable_set("#{@part.variable_name}", eval(@part.data_element_type).find_all_by_data_element_collection_id_and_globe_id(@part.id, @globe_id, :order => @part.order_by_column).paginate(:page => params[:page], :per_page => @part.page_limit))
        else
          # For non-historic data sets, e.g. personal data; statuses; overdraft limits; etc. we
          # only need to retrieve one record.
          if (hash_of_variables[@part.variable_name] == 1)
            puts @part.inspect
            puts @globe_id
#            instance_variable_set("#{@part.variable_name}", eval(@part.data_element_type).find(:first, :conditions => { :data_element_collection_id => @part.id, :globe_id => @globe_id }, :order => "version DESC"))
            instance_variable_set("#{@part.variable_name}", @part.data_element_type.constantize.find(:first, :conditions => { :data_element_collection_id => @part.id, :globe_id => @globe_id }, :order => "version DESC"))
          else
            offset = hash_of_variables["#{@part.variable_name}_offset"]
#            instance_variable_set("@tmp", eval(@part.data_element_type).find_by_data_element_collection_id_and_globe_id(@part.id, @globe_id, :order => "created_at DESC"))
            instance_variable_set("@tmp", @part.data_element_type.constantize.find_by_data_element_collection_id_and_globe_id(@part.id, @globe_id, :order => "created_at DESC"))
            hash_of_variables["#{@part.variable_name}_offset"] = hash_of_variables["#{@part.variable_name}_offset"] + 1
            instance_variable_set("#{@part.variable_name}_array", eval("#{@part.variable_name}_array + [@tmp]"))
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
          @data_element.version = @retain_data_element.version + 1
          @data_element.updated_at = Time.now

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
end
