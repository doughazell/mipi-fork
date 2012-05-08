class CreateMessageDataElements < ActiveRecord::Migration
  def self.up
    create_table :message_data_elements do |t|
      t.boolean :hidden
      t.integer :message_id
      t.string :message_text
    end
    CreateTheViewForCITIEs(MessageDataElement)
  end

  def self.down
    DropTheViewForCITIEs(MessageDataElement)
    drop_table :message_data_elements
  end
end
