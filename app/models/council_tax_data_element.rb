# @author Paul Long
class CouncilTaxDataElement < DataElement
  acts_as_citier
  
  attr_accessible :full_name, :account_number, :contact_address_line_1, :contact_address_line_2, :contact_address_line_3, :contact_city, :contact_county, :contact_postcode, :property_address_line_1, :property_address_line_2, :property_address_line_3, :property_city, :property_county, :property_postcode, :property_reference, :band, :date_of_issue
end
