class HouseDataElement < PropertyDataElement
  acts_as_citier
  
  attr_accessible :address_data_element_id, :year_built, :property_type, :ownership_type, :bedrooms, :bathrooms, :reception_rooms, :garden, :roof_material, :external_construction, :flood_plain
end
