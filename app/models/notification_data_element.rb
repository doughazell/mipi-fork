class NotificationDataElement < DataElement
  acts_as_citier
  
  has_many :reminder_data_elements

  attr_accessible :email
end
