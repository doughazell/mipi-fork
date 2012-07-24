class CreateVehicleReminderTypeDataElements < ActiveRecord::Migration
  def self.up
    create_table :vehicle_reminder_type_data_elements do |t|
      t.string :description
    end
    CreateTheViewForCITIEs(VehicleReminderTypeDataElement)
  end

  def self.down
    DropTheViewForCITIEs(VehicleReminderTypeDataElement)
    drop_table :vehicle_reminder_type_data_elements
  end
end
