class CreateEnhancedTransactionDataElements < ActiveRecord::Migration
  def self.up
    create_table :enhanced_transaction_data_elements do |t|
      t.integer :party_id
    end
    create_citier_view(EnhancedTransactionDataElement)
  end

  def self.down
    drop_citier_view(EnhancedTransactionDataElement)
    drop_table :enhanced_transaction_data_elements
  end
end
