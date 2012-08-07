class DataDomainDataElement < DataElement
  acts_as_cities
  
  has_many :data_sub_domain_data_elements

  DEFAULT_VARIABLE_NAME = "@data_domain"

  def friendly_name
    short_name
  end
end
