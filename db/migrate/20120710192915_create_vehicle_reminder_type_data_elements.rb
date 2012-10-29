class CreateVehicleReminderTypeDataElements < ActiveRecord::Migration
  def self.up
    create_table :vehicle_reminder_type_data_elements do |t|
      t.string :description
    end
    create_citier_view(VehicleReminderTypeDataElement)
  end

  def self.down
    drop_citier_view(VehicleReminderTypeDataElement)
    drop_table :vehicle_reminder_type_data_elements
  end
end
