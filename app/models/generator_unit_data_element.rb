class GeneratorUnitDataElement < DataElement
  acts_as_cities
  belongs_to :power_station_data_element

  attr_accessible :code, :sem_code, :installed_capacity, :fixed_heat_constant, :start_hours_hot, :start_hours_cold, :power_station_data_element_id
#  attr_accessible user_column_data.collect {|v| v.to_sym }
  
  DEFAULT_VALUE = mother_class::DEFAULT_VALUE + [:code, :installed_capacity]
  DEFAULT_VARIABLE_NAME = "@unit"
end
