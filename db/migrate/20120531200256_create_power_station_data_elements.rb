class CreatePowerStationDataElements < ActiveRecord::Migration
  def self.up
    create_table :power_station_data_elements do |t|
      t.string :full_name
      t.string :code
      t.string :primary_fuel_type
      t.string :secondary_fuel_type
      t.string :location
      t.integer :capacity
      t.date :commissioned
    end
    CreateTheViewForCITIEs(PowerStationDataElement)
  end

  def self.down
    DropTheViewForCITIEs(PowerStationDataElement)
    drop_table :power_station_data_elements
  end
end
