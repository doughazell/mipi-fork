class CreateTransactionTypeReferences < ActiveRecord::Migration
  def self.up
    create_table :transaction_type_references do |t|
      t.string :code
      t.string :definition

      t.timestamps
    end
  end

  def self.down
    drop_table :transaction_type_references
  end
end
