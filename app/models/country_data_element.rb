class CountryDataElement < DataElement
  acts_as_citier

  attr_accessible :iso_short_name, :iso_2_code, :iso_3_code, :numeric_code, :iso_3166_2_code
  
  DEFAULT_VARIABLE_NAME = "@country"
end
