class CreateDataElements < ActiveRecord::Migration
  def self.up
    create_table :data_elements do |t|
      t.string :type
      t.string :name
      t.integer :data_element_collection_id
      t.integer :user_id
      t.integer :ready_to_archive
      t.string :label
      t.boolean :mandatory
      t.integer :globe_id

      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :data_elements
  end
end
