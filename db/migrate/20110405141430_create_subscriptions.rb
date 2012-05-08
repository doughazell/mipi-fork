class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.integer :source_link_id
      t.integer :destination_link_id
      t.integer :subscription_type_id

      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
