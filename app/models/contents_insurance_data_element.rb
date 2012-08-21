class ContentsInsuranceDataElement < InsuranceDataElement
  acts_as_cities
  
  attr_accessible :insured_value, :excess, :house_data_element_id
end
