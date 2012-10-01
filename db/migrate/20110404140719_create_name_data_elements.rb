class CreateNameDataElements < ActiveRecord::Migration
  def self.up
    create_table :name_data_elements do |t|
      t.string :first_name
      t.string :other_names
      t.string :last_name
    end
    create_citier_view(NameDataElement)
  end

  def self.down
    drop_citier_view(NameDataElement)
    drop_table :name_data_elements
  end
end
