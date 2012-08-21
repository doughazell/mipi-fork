# @author Paul Long
class FinancialAccountDataElement < DataElement
  acts_as_cities

  attr_accessible :first_name, :last_name, :date_of_birth, :bank_name, :account_name, :account_type, :sort_code, :account_number, :bank_address_id, :open_date, :closed_date, :overdraft_limit
end
