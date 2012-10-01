class ContactDataElement < DataElement
  acts_as_citier
  
  attr_accessible :first_name,  :other_names, :last_name, :email
end
