class CreateVehicleServiceDataElements < ActiveRecord::Migration
  def self.up
    create_table :vehicle_service_data_elements do |t|
      t.date :service_date
      t.string :details
      t.string :signator
      t.integer :vehicle_data_element_id
    end
    create_citier_view(VehicleServiceDataElement)
  end

  def self.down
    drop_citier_view(VehicleServiceDataElement)
    drop_table :vehicle_service_data_elements
  end
end
