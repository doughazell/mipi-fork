class DataSubDomainDataElement < DataElement
  acts_as_citier
  
  belongs_to :data_domain_data_element
  has_many :data_set_data_elements, :conditions => ['current = ?', true]

  attr_accessible :code, :short_name, :description, :data_domain_data_element_id
  
  DEFAULT_VARIABLE_NAME = "@data_sub_domain"

  def friendly_name
    short_name
  end

end

