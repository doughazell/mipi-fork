class StringDataElements < ActiveRecord::Migration
  def self.up
    create_table :string_data_elements do |t|
      t.string :value
    end
    
    self.create_citier_view()
  end

  def self.down
    drop_table :string_data_elements
  end
end
