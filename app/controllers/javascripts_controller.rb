class JavascriptsController < ApplicationController
  def dynamic_data_elements
    
    # Retrieve the Globe.
    @globe = Globe.find(params[:id])
    
    # Retrieve all Data Elements within this globe.
    @data_elements = DataElement.find_all_by_globe_id(@globe.id)

    # Obtain an array of all the Data Element Collections associated with all the
    # Data Elements within this Globe.
    @data_element_collections = Array.new
    @data_elements.each do |e|
      @data_element_collections << e.data_element_collection
    end
    
    # Remove any duplicates.
    @data_element_collections.uniq!

#    render :layout => false
  end
end
