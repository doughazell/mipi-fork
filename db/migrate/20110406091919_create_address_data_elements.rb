class CreateAddressDataElements < ActiveRecord::Migration
  def self.up
    create_table :address_data_elements do |t|
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_line_3
      t.string :city
      t.string :post_code
      t.string :country
    end
    create_citier_view(AddressDataElement)
  end

  def self.down
    drop_citier_view(AddressDataElement)
    drop_table :address_data_elements
  end
end
