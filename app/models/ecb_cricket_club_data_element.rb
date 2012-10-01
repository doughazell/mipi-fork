class EcbCricketClubDataElement < DataElement
  acts_as_citier
  
  attr_accessible :location, :county, :weburl, :contact_name, :contact_number
end
