class CreateCurrencyDataElements < ActiveRecord::Migration
  def self.up
    create_table :currency_data_elements do |t|
      t.string :iso_code
      t.string :numeric_code
      t.integer :decimal_places
      t.string :currency_name
    end
    create_citier_view(CurrencyDataElement)
  end
  
  def self.down
    drop_citier_view(CurrencyDataElement)
    drop_table :currency_data_elements
  end
end
