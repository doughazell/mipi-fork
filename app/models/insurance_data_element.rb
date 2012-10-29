class InsuranceDataElement < DataElement
  acts_as_citier

  attr_accessible :policy_reference, :expires, :commences
end
