# @author Paul Long
class NameDataElement < DataElement
  acts_as_citier

  attr_accessible :hidden, :message_id, :message_text
end
