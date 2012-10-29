class CreatePropertyDataElements < ActiveRecord::Migration
  def self.up
    create_table :property_data_elements do |t|
      t.integer :address_data_element_id
      t.integer :year_built
    end
    create_citier_view(PropertyDataElement)
  end

  def self.down
    drop_citier_view(PropertyDataElement)
    drop_table :property_data_elements
  end
end
