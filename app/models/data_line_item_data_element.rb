class DataLineItemDataElement < DataElement
  acts_as_citier
  
  belongs_to :data_set_data_element
  
  attr_accessible :code, :short_name, :description, :data_set_data_element_id

  DEFAULT_VARIABLE_NAME = "@line_item"
  DEFAULT_PAGE_LIMIT = 10

  def friendly_name
    short_name
  end
end
