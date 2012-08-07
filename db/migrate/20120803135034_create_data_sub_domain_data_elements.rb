class CreateDataSubDomainDataElements < ActiveRecord::Migration
  def self.up
    create_table :data_sub_domain_data_elements do |t|
      t.string :code
      t.string :short_name
      t.string :description
      t.integer :data_domain_data_element_id
    end
    CreateTheViewForCITIEs(DataSubDomainDataElement)
  end

  def self.down
    DropTheViewForCITIEs(DataSubDomainDataElement)
    drop_table :data_sub_domain_data_elements
  end
end
