class CreateDataDomainDataElements < ActiveRecord::Migration
  def self.up
    create_table :data_domain_data_elements do |t|
      t.string :code
      t.string :short_name
      t.string :description
    end
    CreateTheViewForCITIEs(DataDomainDataElement)
  end

  def self.down
    DropTheViewForCITIEs(DataDomainDataElement)
    drop_table :data_domain_data_elements
  end
end
