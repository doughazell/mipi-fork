class CreateSubscriptionMessageDataElements < ActiveRecord::Migration
  def self.up
    create_table :subscription_message_data_elements do |t|
      t.integer :subscription_id
    end
    CreateTheViewForCITIEs(SubscriptionMessageDataElement)
  end

  def self.down
    DropTheViewForCITIEs(SubscriptionMessageDataElement)
    drop_table :subscription_message_data_elements
  end
end
