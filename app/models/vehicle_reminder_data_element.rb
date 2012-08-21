class VehicleReminderDataElement < DataElement
  acts_as_cities
  
  belongs_to :notification_data_element
  belongs_to :reminder_type_data_element
  belongs_to :vehicle_data_element

  attr_accessible :reminder_date, :notification_data_element_id, :reminder_type_data_element_id
end
