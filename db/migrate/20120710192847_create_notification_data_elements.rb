class CreateNotificationDataElements < ActiveRecord::Migration
  def self.up
    create_table :notification_data_elements do |t|
      t.string :email
    end
    CreateTheViewForCITIEs(NotificationDataElement)
  end

  def self.down
    DropTheViewForCITIEs(NotificationDataElement)
    drop_table :notification_data_elements
  end
end
