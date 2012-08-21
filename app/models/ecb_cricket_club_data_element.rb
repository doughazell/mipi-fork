class EcbCricketClubDataElement < DataElement
  acts_as_cities
  
  attr_accessible :location, :county, :weburl, :contact_name, :contact_number
end
