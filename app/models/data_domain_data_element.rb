class DataDomainDataElement < DataElement
  acts_as_citier
  
  has_many :data_sub_domain_data_elements

  attr_accessible :code, :short_name, :description
  
  DEFAULT_VARIABLE_NAME = "@data_domain"

  def friendly_name
    short_name
  end
end
