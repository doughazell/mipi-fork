class CreateDataElementLinks < ActiveRecord::Migration
  def self.up
    create_table :data_element_links do |t|
      t.string :remote_globe_identifier
      t.integer :data_element_id
      t.string :attribute_name

      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :data_element_links
  end
end
