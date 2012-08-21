# @author Paul Long
class TransactionDataElement < DataElement
  acts_as_cities
  
  attr_accessible :transfer_date, :transaction_type, :description, :value, :balance
end
