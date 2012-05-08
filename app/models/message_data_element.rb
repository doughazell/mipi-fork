# The Message Data Element data model is slightly different to the other classes derived
# from DataElement in that the constant @@historical_retention is set to false. This is
# because we do not want to retain a historical audit of the message as it changes.
# An important flag within this DataElement is 'hidden' which is set when the user wishes
# to dismiss the message from being visible on screen. This behavious is very particular
# to messages, although it could be envisaged to be replicated in other DataElement-derived
# classes.
# @author Paul Long
class MessageDataElement < DataElement
  @@historical_retention = false

  acts_as_cities
  
  belongs_to :message

end

