class CreateFirstNameDataElements < ActiveRecord::Migration
  def self.up
    create_table :first_name_data_elements do |t|
    end
    self.CreateTheViewForCITIEs(FirstNameDataElements)
  end

  def self.down
    self.DropTheViewForCITIEs(FirstNameDataElements)
    drop_table :first_name_data_elements
  end
end
