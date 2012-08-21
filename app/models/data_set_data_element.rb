class DataSetDataElement < DataElement
  acts_as_cities
  
  belongs_to :data_sub_domain_data_element
  has_many :data_line_item_data_elements

  attr_accessible :code, :short_name, :description, :data_sub_domain_data_element_id
  
  DEFAULT_VARIABLE_NAME = "@data_set"

  def friendly_name
    short_name
  end
end