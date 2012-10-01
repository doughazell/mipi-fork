class CreateNotificationDataElements < ActiveRecord::Migration
  def self.up
    create_table :notification_data_elements do |t|
      t.string :email
    end
    create_citier_view(NotificationDataElement)
  end

  def self.down
    drop_citier_view(NotificationDataElement)
    drop_table :notification_data_elements
  end
end
