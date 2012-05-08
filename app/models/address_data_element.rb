# Provide basic UK addressing capabilities. In order to be more specific
# or in order to cater for a different layout of address lines, you should
# derive from this class or derive a difference class from DataElement
# @author Paul Long
class AddressDataElement < DataElement
  acts_as_cities
end
