class CreateNameDataElements < ActiveRecord::Migration
  def self.up
    create_table :name_data_elements do |t|
      t.string :first_name
      t.string :other_names
      t.string :last_name
    end
    CreateTheViewForCITIEs(NameDataElement)
  end

  def self.down
    DropTheViewForCITIEs(NameDataElement)
    drop_table :name_data_elements
  end
end
