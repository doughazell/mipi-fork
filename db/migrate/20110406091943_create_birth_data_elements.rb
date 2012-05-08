class CreateBirthDataElements < ActiveRecord::Migration
  def self.up
    create_table :birth_data_elements do |t|
      t.date :date_of_birth
      t.string :town_of_birth
      t.string :country_of_birth
    end
    CreateTheViewForCITIEs(BirthDataElement)
  end

  def self.down
    DropTheViewForCITIEs(BirthDataElement)
    drop_table :birth_data_elements
  end
end
