class VehicleReminderDataElement < DataElement
  acts_as_cities
  
  belongs_to :notification_data_element
  belongs_to :reminder_type_data_element
  belongs_to :vehicle_data_element
end
