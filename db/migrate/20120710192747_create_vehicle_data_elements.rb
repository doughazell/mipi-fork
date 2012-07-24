class CreateVehicleDataElements < ActiveRecord::Migration
  def self.up
    create_table :vehicle_data_elements do |t|
      t.string :registration
      t.string :make
      t.string :model
      t.string :colour
    end
    CreateTheViewForCITIEs(VehicleDataElement)
  end

  def self.down
    DropTheViewForCITIEs(VehicleDataElement)
    drop_table :vehicle_data_elements
  end
end