class CreateContentsInsuranceDataElements < ActiveRecord::Migration
  def self.up
    create_table :contents_insurance_data_elements do |t|
      t.float :insured_value
      t.float :excess
      t.integer :house_data_element_id
    end
    create_citier_view(ContentsInsuranceDataElement)
  end

  def self.down
    drop_citier_view(ContentsInsuranceDataElement)
    drop_table :contents_insurance_data_elements
  end
end
