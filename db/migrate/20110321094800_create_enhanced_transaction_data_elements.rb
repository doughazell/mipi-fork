class CreateEnhancedTransactionDataElements < ActiveRecord::Migration
  def self.up
    create_table :enhanced_transaction_data_elements do |t|
      t.integer :party_id
    end
    CreateTheViewForCITIEs(EnhancedTransactionDataElement)
  end

  def self.down
    DropTheViewForCITIEs(EnhancedTransactionDataElement)
    drop_table :enhanced_transaction_data_elements
  end
end
