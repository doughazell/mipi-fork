class CreateLastNameDataElements < ActiveRecord::Migration
  def self.up
    create_table :last_name_data_elements do |t|
    end
    self.CreateTheViewForCITIEs(LastNameDataElements)
  end

  def self.down
    self.DropTheViewForCITIEs(LastNameDataElements)
    drop_table :last_name_data_elements
  end
end
