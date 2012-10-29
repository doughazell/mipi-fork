class CreateBuildingsInsuranceDataElements < ActiveRecord::Migration
  def self.up
    create_table :buildings_insurance_data_elements do |t|
      t.float :insured_value
      t.integer :house_data_element_id
    end
    create_citier_view(BuildingsInsuranceDataElement)
  end

  def self.down
    drop_citier_view(BuildingsInsuranceDataElement)
    drop_table :buildings_insurance_data_elements
  end
end
