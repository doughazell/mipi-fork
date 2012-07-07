class CreateDataElementCollections < ActiveRecord::Migration
  def self.up
    create_table :data_element_collections do |t|
      t.string :name
      t.string :security
      t.string :archive_criteria
#      t.integer :data_sheet_id
      t.string :data_element_type
      t.integer :page_limit
      t.boolean :historic
      t.string :variable_name
      t.string :order_by_column, :default => "created_at DESC"
      t.integer :globe_id

      t.timestamps
    end
  end

  def self.down
    drop_table :data_element_collections
  end
end
