class ContactDataElement < DataElement
  acts_as_cities
  
  attr_accessible :first_name,  :other_names, :last_name, :email
end
