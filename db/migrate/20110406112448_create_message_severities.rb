class CreateMessageSeverities < ActiveRecord::Migration
  def self.up
    create_table :message_severities do |t|
      t.string :name
      t.integer :level
      t.string :definition

      t.timestamps
    end
  end

  def self.down
    drop_table :message_severities
  end
end
