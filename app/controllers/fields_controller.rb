class FieldsController < ApplicationController
  respond_to :js
  
  def show
    @field = params[:id]
    @globe = Globe.find(params[:globe_id])
    @data_element = DataElement.find(params[:data_element_id])
#    @profile = @globe.profiles.find(params[:profile_id])
#    @data_sheet = @profile.data_sheets.find(params[:data_sheet_id])
    @meta_data = DataElementMetaData.find_by_data_element_type_and_name(@data_element.type, @field)
    if @meta_data.nil? then
      @meta_data = DataElementMetaData.find_by_data_element_type_and_name('[DEFAULT]', '[DEFAULT]')
    end

    @subscriptions = Subscription.find_all_references(@data_element, @field)
    @data_value = @data_element[@field]
    @count_of_subs = 0
    if !@subscriptions.nil? then
      @count_of_subs = @subscriptions.count
    end

    respond_to do |format|
      format.html
      format.xml  { head :ok }
    end
  end

  def link
    
    ##-- SOURCE 
    # E.g. first name; date_of_birth; etc.
    @field = params[:id]
    
    # The globe we were active within.
    @globe = Globe.find(params[:globe_id])
    
    # All the children to this globe.
    @shadowglobes = @globe.children
    
    # The specific data element we want to link to.
    @data_element = DataElement.find(params[:data_element_id])
    
    # The collection of this data element.
    @data_element_collection = @data_element.data_element_collection

    # Seek the meta data for the source object.    
    @meta_data = DataElementMetaData.find_by_data_element_type_and_name(@data_element.type, @field)


    #-- TARGET
    # Retrieve all elements associated with the globe id (TODO - this shoudl be target_globe_id)
    @all_data_elements = DataElement.find_all_by_globe_id(@globe.id)
    
    # Empty lists of collections.
    @all_data_element_collections = []
    @all_data_elements.each do |e|
      @all_data_element_collections << e.data_element_collection
    end
    
    # No duplicates.
    @all_data_element_collections.uniq!

    # With the Unique list of collection, determine the field names that
    # will be available to us.
    @field_list = []
    @all_data_element_collections.each do |c|
      @field_list << { [c.id, c.name, c.data_element_type] => eval("#{c.data_element_type}.user_column_data") }
    end
  
#    redirect_to :controller => "javascripts", :action => "dynamic_data_elements"
    respond_to do |format|
      format.html
      format.xml  { head :ok }
      format.js
    end
  end
end
