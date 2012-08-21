class NotificationDataElement < DataElement
  acts_as_cities
  
  has_many :reminder_data_elements

  attr_accessible :email
end
