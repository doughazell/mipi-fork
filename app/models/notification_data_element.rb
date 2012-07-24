class NotificationDataElement < DataElement
  acts_as_cities
  
  has_many :reminder_data_elements
end
