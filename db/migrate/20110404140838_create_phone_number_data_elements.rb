class CreatePhoneNumberDataElements < ActiveRecord::Migration
  def self.up
    create_table :phone_number_data_elements do |t|
      t.string :phone_type
      t.string :phone_number
    end
    create_citier_view(PhoneNumberDataElement)
  end

  def self.down
    drop_citier_view(PhoneNumberDataElement)
    drop_table :phone_number_data_elements
  end
end
