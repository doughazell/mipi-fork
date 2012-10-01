class BuildingsInsuranceDataElement < InsuranceDataElement
  acts_as_citier
  
  attr_accessible :insured_value, :house_data_element_id
end
