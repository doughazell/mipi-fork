class CreateDataLineItemDataElements < ActiveRecord::Migration
  def self.up
    create_table :data_line_item_data_elements do |t|
      t.string :code
      t.string :short_name
      t.string :description
      t.integer :data_set_data_element_id
    end
    create_citier_view(DataLineItemDataElement)
  end

  def self.down
    drop_citier_view(DataLineItemDataElement)
    drop_table :data_line_item_data_elements
  end
end
