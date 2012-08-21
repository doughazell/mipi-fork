class VehicleDataElement < DataElement
  acts_as_cities
  
  has_many :vehicle_service_data_elements
  has_many :vehicle_reminder_data_elements

  attr_accessible :registration, :make, :model, :colour
end
