class PowerStationDataElement < DataElement
  acts_as_cities
  has_many :generator_unit_data_element
  has_many :transmission_loss_adjustment_data_elements
end
