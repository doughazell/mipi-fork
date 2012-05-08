class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :name
      t.string :definition
      t.integer :message_severity_id

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
