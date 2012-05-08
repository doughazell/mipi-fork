class DataElements < ActiveRecord::Migration
  def self.up
    create_table :data_elements do |t|
      t.string :inheritance_column
      t.integer :data_element_collection_id
      t.integer :user_id
      t.boolean :ready_to_archive
      t.string :label
      t.boolean :mandatory
      
      t.timestamps
  end

  def self.down
    drop_table :data_elements
  end
end
