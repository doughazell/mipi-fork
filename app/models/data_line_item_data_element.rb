class DataLineItemDataElement < DataElement
  acts_as_cities
  
  belongs_to :data_set_data_element
  
  DEFAULT_VARIABLE_NAME = "@line_item"

  def friendly_name
    short_name
  end
end
