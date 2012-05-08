class CreateContactDataElements < ActiveRecord::Migration
  def self.up
    create_table :contact_data_elements do |t|
      t.string :first_name
      t.string :other_names
      t.string :last_name
      t.string :email
    end
    CreateTheViewForCITIEs(ContactDataElement)
  end

  def self.down
    DropTheViewForCITIEs(ContactDataElement)
    drop_table :contact_data_elements
  end
end
