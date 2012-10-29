class CreateHouseDataElements < ActiveRecord::Migration
  def self.up
    create_table :house_data_elements do |t|
      t.string :property_type
      t.string :ownership_type
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :reception_rooms
      t.boolean :garden
      t.string :roof_material
      t.string :external_construction
      t.integer :flood_plain
    end
    create_citier_view(HouseDataElement)
  end

  def self.down
    drop_citier_view(HouseDataElement)
    drop_table :house_data_elements
  end
end
