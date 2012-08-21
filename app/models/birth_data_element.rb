# @author Paul Long
class BirthDataElement < DataElement
  acts_as_cities
  
  attr_accessible :date_of_birth, :town_of_birth, :country_of_birth
end
