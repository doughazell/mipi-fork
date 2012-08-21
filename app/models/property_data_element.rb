class PropertyDataElement < DataElement
  acts_as_cities
  
  attr_accessible :address_data_element_id, :year_built
end
