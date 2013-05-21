# This DataElement-derived model class describes attributes of a physical
# generator within an electrical power station. It retains the following
# methods:
#
# code: specific abbreviation used within the organisation to uniquely
# identify the generator unit within the organisation.
#
# sem_code: unique code across the whole Single Electicity Market industry
# to identify a generator unit.
#
# installed_capacity: the maximum capacity at which the generator unit is
# able to run at in GWh.
#
# @author Paul Long
class GeneratorUnitDataElement < DataElement
  acts_as_citier
  belongs_to :power_station_data_element

  attr_accessible :code, :sem_code, :installed_capacity, :fixed_heat_constant, :start_hours_hot, :start_hours_cold, :power_station_data_element_id
#  attr_accessible user_column_data.collect {|v| v.to_sym }
  
#  DEFAULT_VALUE = mother_class::DEFAULT_VALUE + [:code, :installed_capacity]
  DEFAULT_VALUE = DEFAULT_VALUE + [:code, :installed_capacity]
  DEFAULT_VARIABLE_NAME = "@unit"
  
  META_DATA = DataElement::META_DATA.merge( {
    'start_hours_hot' => {
      :format => {
        :type => :decimal,
        :precision => 2
      }
    }
  })
end
