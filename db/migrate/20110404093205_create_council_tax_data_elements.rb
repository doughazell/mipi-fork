class CreateCouncilTaxDataElements < ActiveRecord::Migration
  def self.up
    create_table :council_tax_data_elements do |t|
      t.string :full_name
      t.string :account_number
      t.string :contact_address_line_1
      t.string :contact_address_line_2
      t.string :contact_address_line_3
      t.string :contact_city
      t.string :contact_county
      t.string :contact_postcode
      t.string :property_address_line_1
      t.string :property_address_line_2
      t.string :property_address_line_3
      t.string :property_city
      t.string :property_county
      t.string :property_postcode
      t.string :property_reference
      t.string :band
      t.date :date_of_issue
    end
    CreateTheViewForCITIEs(CouncilTaxDataElement)
  end

  def self.down
    DropTheViewForCITIEs(CouncilTaxDataElement)
    drop_table :council_tax_data_elements
  end
end
