class VehicleServiceDataElement < DataElement
  acts_as_cities
  
  belongs_to :vehicle_data_element
end
