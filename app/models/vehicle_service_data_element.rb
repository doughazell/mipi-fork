class VehicleServiceDataElement < DataElement
  acts_as_cities
  
  belongs_to :vehicle_data_element

  attr_accessible :service_date, :details, :signator, :vehicle_data_element_id
end
