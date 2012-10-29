class CreateDataDomainDataElements < ActiveRecord::Migration
  def self.up
    create_table :data_domain_data_elements do |t|
      t.string :code
      t.string :short_name
      t.string :description
    end
    create_citier_view(DataDomainDataElement)
  end

  def self.down
    drop_citier_view(DataDomainDataElement)
    drop_table :data_domain_data_elements
  end
end
