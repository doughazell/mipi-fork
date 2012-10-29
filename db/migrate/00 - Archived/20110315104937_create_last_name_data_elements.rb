class CreateLastNameDataElements < ActiveRecord::Migration
  def self.up
    create_table :last_name_data_elements do |t|
    end
    self.create_citier_view(LastNameDataElements)
  end

  def self.down
    self.drop_citier_view(LastNameDataElements)
    drop_table :last_name_data_elements
  end
end
