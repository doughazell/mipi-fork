# @author Paul Long
class PhoneNumberDataElement < DataElement
  acts_as_citier

  attr_accessible :phone_type, :phone_number
end
