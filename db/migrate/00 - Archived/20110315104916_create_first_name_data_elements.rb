class CreateFirstNameDataElements < ActiveRecord::Migration
  def self.up
    create_table :first_name_data_elements do |t|
    end
    self.create_citier_view(FirstNameDataElements)
  end

  def self.down
    self.drop_citier_view(FirstNameDataElements)
    drop_table :first_name_data_elements
  end
end
