class InsuranceDataElement < DataElement
  acts_as_cities

  attr_accessible :policy_reference, :expires, :commences
end
