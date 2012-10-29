class CreateTransactionDataElements < ActiveRecord::Migration
  def self.up
    create_table :transaction_data_elements do |t|
      t.date :transfer_date
      t.string :transaction_type
      t.string :description
      t.float :value
      t.float :balance
    end
    create_citier_view(TransactionDataElement)
  end

  def self.down
    drop_citier_view(TransactionDataElement)
    drop_table :transaction_data_elements
  end
end
