class CreateCountryDataElements < ActiveRecord::Migration
  def self.up
    create_table :country_data_elements do |t|
      t.string :iso_short_name
      t.string :iso_2_code
      t.string :iso_3_code
      t.string :numeric_code
      t.string :iso_3166_2_code
    end
    create_citier_view(CountryDataElement)
  end
  
  def self.down
    drop_citier_view(CountryDataElement)
    drop_table :country_data_elements
  end
end
