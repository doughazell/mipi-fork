# @author Paul Long
class TransactionDataElement < DataElement
  acts_as_citier
  
  attr_accessible :transfer_date, :transaction_type, :description, :value, :balance
end
