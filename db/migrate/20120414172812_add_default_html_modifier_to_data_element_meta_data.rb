class AddDefaultHtmlModifierToDataElementMetaData < ActiveRecord::Migration
  def self.up
    add_column :data_element_meta_datas, :default_html_modifier, :string, :default => "text_field"
  end

  def self.down
    remove_column :data_element_meta_datas, :default_html_modifier
  end
end
