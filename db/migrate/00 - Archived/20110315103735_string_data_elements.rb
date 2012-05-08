class StringDataElements < ActiveRecord::Migration
  def self.up
    create_table :string_data_elements do |t|
      t.string :value
    end
    
    self.CreateTheViewForCITIEs()
  end

  def self.down
    drop_table :string_data_elements
  end
end
