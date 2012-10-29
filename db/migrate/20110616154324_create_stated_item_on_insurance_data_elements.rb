class CreateStatedItemOnInsuranceDataElements < ActiveRecord::Migration
  def self.up
    create_table :stated_item_on_insurance_data_elements do |t|
      t.string :description
      t.float :value
      t.integer :contents_insurance_data_element_id
    end
    create_citier_view(StatedItemOnInsuranceDataElement)
  end

  def self.down
    drop_citier_view(StatedItemOnInsuranceDataElement)
    drop_table :stated_item_on_insurance_data_elements
  end
end
