class ContentsInsuranceDataElement < InsuranceDataElement
  acts_as_citier
  
  attr_accessible :insured_value, :excess, :house_data_element_id
end
