class StatedItemOnInsuranceDataElement < DataElement
  acts_as_citier

  attr_accessible :description, :value, :contents_insurance_data_element_id
end
