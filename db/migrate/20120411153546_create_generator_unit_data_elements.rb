class CreateGeneratorUnitDataElements < ActiveRecord::Migration
  def self.up
    create_table :generator_unit_data_elements do |t|
      t.string :code
      t.float :installed_capacity
      t.float :fixed_heat_constant
      t.float :start_hours_hot
      t.float :start_hours_cold
      t.integer :power_station_data_element_id
    end
    create_citier_view(GeneratorUnitDataElement)
  end

  def self.down
    drop_citier_view(GeneratorUnitDataElement)
    drop_table :generator_unit_data_elements
  end
end
