class AddColumnToDataElementCollections < ActiveRecord::Migration
  def self.up
    add_column :data_element_collections, :data_sheet_id, :integer
    add_column :data_element_collections, :data_element_type, :string
    add_column :data_element_collections, :page_limit, :integer
    add_column :data_element_collections, :historic, :boolean
    add_column :data_element_collections, :variable_name, :string
  end

  def self.down
    remove_column :data_element_collections, :data_sheet_id
  end
end
