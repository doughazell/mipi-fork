class VehicleReminderTypeDataElement < DataElement
  acts_as_cities
  
  has_many :vehicle_reminder_data_elements

  attr_accessible :description
end
