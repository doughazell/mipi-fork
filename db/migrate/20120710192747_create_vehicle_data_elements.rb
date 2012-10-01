class CreateVehicleDataElements < ActiveRecord::Migration
  def self.up
    create_table :vehicle_data_elements do |t|
      t.string :registration
      t.string :make
      t.string :model
      t.string :colour
    end
    create_citier_view(VehicleDataElement)
  end

  def self.down
    drop_citier_view(VehicleDataElement)
    drop_table :vehicle_data_elements
  end
end