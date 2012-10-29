# Provide basic UK addressing capabilities. In order to be more specific
# or in order to cater for a different layout of address lines, you should
# derive from this class or derive a difference class from DataElement
# @author Paul Long
class AddressDataElement < DataElement
  acts_as_citier
  
  attr_accessible :address_line_1, :address_line_2, :address_line_3, :city, :post_code, :country
end
