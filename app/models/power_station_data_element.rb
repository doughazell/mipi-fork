class PowerStationDataElement < DataElement
  acts_as_cities
  has_many :generator_unit_data_element
  has_many :transmission_loss_adjustment_data_elements

  attr_accessible :full_name, :code, :primary_fuel_type, :secondary_fuel_type, :location, :capacity, :commissioned, :primary_fuel_type_data_element_id, :secondary_fuel_type_data_element_id
  DEFAULT_VARIABLE_NAME = "@station"
end
