class CreateFinancialAccountDataElements < ActiveRecord::Migration
  def self.up
    create_table :financial_account_data_elements do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :bank_name
      t.string :account_name
      t.string :account_type
      t.string :sort_code
      t.string :account_number
      t.integer :bank_address_id
      t.date :open_date
      t.date :closed_date
      t.float :overdraft_limit
    end
    create_citier_view(FinancialAccountDataElement)
  end

  def self.down
    drop_table :financial_account_data_elements
    drop_citier_view(FinancialAccountDataElement)
  end
end
