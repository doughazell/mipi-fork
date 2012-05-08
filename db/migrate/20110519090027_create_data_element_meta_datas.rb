class CreateDataElementMetaDatas < ActiveRecord::Migration
  def self.up
    create_table :data_element_meta_datas do |t|
      t.string :data_element_type
      t.string :name
      t.string :definition
      t.string :field_type

      t.timestamps
    end
  end

  def self.down
    drop_table :data_element_meta_datas
  end
end
