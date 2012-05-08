class CreateInsuranceDataElements < ActiveRecord::Migration
  def self.up
    create_table :insurance_data_elements do |t|
      t.string :policy_reference
      t.date :expires
      t.date :commences
    end
    CreateTheViewForCITIEs(InsuranceDataElement)
  end

  def self.down
    DropTheViewForCITIEs(InsuranceDataElement)
    drop_table :insurance_data_elements
  end
end
