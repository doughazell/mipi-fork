class CurrencyDataElement < DataElement
  acts_as_citier

  attr_accessible :iso_code, :numeric_code, :decimal_places, :currency_name
  
  DEFAULT_VARIABLE_NAME = "@currency"
end
