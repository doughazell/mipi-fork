class BuildingsInsuranceDataElement < InsuranceDataElement
  acts_as_cities
  
  attr_accessible :insured_value, :house_data_element_id
end
