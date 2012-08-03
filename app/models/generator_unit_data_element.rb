class GeneratorUnitDataElement < DataElement
  acts_as_cities
  belongs_to :power_station_data_element

  DEFAULT_VALUE = mother_class::DEFAULT_VALUE + [:code, :installed_capacity]
end
