class CreatePropertyDataElements < ActiveRecord::Migration
  def self.up
    create_table :property_data_elements do |t|
      t.integer :address_data_element_id
      t.integer :year_built
    end
    CreateTheViewForCITIEs(PropertyDataElement)
  end

  def self.down
    DropTheViewForCITIEs(PropertyDataElement)
    drop_table :property_data_elements
  end
end
