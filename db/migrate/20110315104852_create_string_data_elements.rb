class CreateStringDataElements < ActiveRecord::Migration
  def self.up
    create_table :string_data_elements do |t|
      t.string :value
    end
    CreateTheViewForCITIEs(StringDataElement)
  end

  def self.down
    DropTheViewForCITIEs(StringDataElement)
    drop_table :string_data_elements
  end
end
