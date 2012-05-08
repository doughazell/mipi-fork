class CreateBuildingsInsuranceDataElements < ActiveRecord::Migration
  def self.up
    create_table :buildings_insurance_data_elements do |t|
      t.float :insured_value
      t.integer :house_data_element_id
    end
    CreateTheViewForCITIEs(BuildingsInsuranceDataElement)
  end

  def self.down
    DropTheViewForCITIEs(BuildingsInsuranceDataElement)
    drop_table :buildings_insurance_data_elements
  end
end
