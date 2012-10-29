class TransmissionLossAdjustmentDataElement < DataElement
  acts_as_citier
  belongs_to :power_station_data_element

  attr_accessible :month, :power_station_data_element_id, :adjustment, :daytime_indicator
end
