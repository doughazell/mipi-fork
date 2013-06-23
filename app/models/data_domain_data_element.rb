class DataDomainDataElement < DataElement
  acts_as_citier
  
  has_many :data_sub_domain_data_elements, :conditions => ['current = ?', true]

  attr_accessible :code, :short_name, :description
  
  DEFAULT_VARIABLE_NAME = "@data_domain"
  DEFAULT_DATA_SHEET = {
    :style_sheet => "custom_styles/ftp/ftp.css",
    :file_location => "/data_sheets/pages/ftp/data_domain.html.erb"
  }
  
  def friendly_name
    short_name
  end
end
