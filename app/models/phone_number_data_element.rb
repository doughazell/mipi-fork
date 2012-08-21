# @author Paul Long
class PhoneNumberDataElement < DataElement
  acts_as_cities

  attr_accessible :phone_type, :phone_number
end
