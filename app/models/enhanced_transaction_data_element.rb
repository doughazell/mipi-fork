# @author Paul Long
class EnhancedTransactionDataElement < TransactionDataElement
  acts_as_cities

  attr_accessible :transfer_date, :transaction_type, :description, :value, :balance, :party_id
end
