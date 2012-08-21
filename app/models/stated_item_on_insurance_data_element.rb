class StatedItemOnInsuranceDataElement < DataElement
  acts_as_cities

  attr_accessible :description, :value, :contents_insurance_data_element_id
end
