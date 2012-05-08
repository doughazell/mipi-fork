class CreateSubscriptionEvalutaionQueues < ActiveRecord::Migration
  def self.up
    create_table :subscription_evalutaion_queues do |t|
      t.integer :subscription_id

      t.timestamps
    end
  end

  def self.down
    drop_table :subscription_evalutaion_queues
  end
end
