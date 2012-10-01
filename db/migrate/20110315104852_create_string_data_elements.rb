class CreateStringDataElements < ActiveRecord::Migration
  def self.up
    create_table :string_data_elements do |t|
      t.string :value
    end
    create_citier_view(StringDataElement)
  end

  def self.down
    drop_citier_view(StringDataElement)
    drop_table :string_data_elements
  end
end
