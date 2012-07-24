class CreateVehicleReminderDataElements < ActiveRecord::Migration
  def self.up
    create_table :vehicle_reminder_data_elements do |t|
      t.date :reminder_date
      t.integer :notification_data_element_id
      t.integer :reminder_type_data_element_id
    end
    CreateTheViewForCITIEs(VehicleReminderDataElement)
  end

  def self.down
    DropTheViewForCITIEs(VehicleReminderDataElement)
    drop_table :vehicle_reminder_data_elements
  end
end
