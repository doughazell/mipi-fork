class CreateTransactionDataElements < ActiveRecord::Migration
  def self.up
    create_table :transaction_data_elements do |t|
      t.date :transfer_date
      t.string :transaction_type
      t.string :description
      t.float :value
      t.float :balance
    end
    CreateTheViewForCITIEs(TransactionDataElement)
  end

  def self.down
    DropTheViewForCITIEs(TransactionDataElement)
    drop_table :transaction_data_elements
  end
end
