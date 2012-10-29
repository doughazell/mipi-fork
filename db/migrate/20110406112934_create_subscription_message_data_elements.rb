class CreateSubscriptionMessageDataElements < ActiveRecord::Migration
  def self.up
    create_table :subscription_message_data_elements do |t|
      t.integer :subscription_id
    end
    create_citier_view(SubscriptionMessageDataElement)
  end

  def self.down
    drop_citier_view(SubscriptionMessageDataElement)
    drop_table :subscription_message_data_elements
  end
end
