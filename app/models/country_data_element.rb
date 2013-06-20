class CountryDataElement < DataElement
  acts_as_citier

  attr_accessible :iso_short_name, :iso_2_code, :iso_3_code, :numeric_code, :iso_3166_2_code
  
  DEFAULT_VARIABLE_NAME = "@country"
  DEFAULT_DATA_SHEET = {
    :style_sheet => 'custom_styles/staticdata/staticdata.css',
    :file_location => '/data_sheets/pages/staticdata/country.html.erb'
  }
end
