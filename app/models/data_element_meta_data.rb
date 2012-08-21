class DataElementMetaData < ActiveRecord::Base
  attr_accessible :data_element_type, :name, :definition, :field_type, :default_html_modifier
end
