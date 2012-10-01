class CreateTransmissionLossAdjustmentDataElements < ActiveRecord::Migration
  def self.up
    create_table :transmission_loss_adjustment_data_elements do |t|
      t.datetime :month
      t.integer :power_station_data_element_id
      t.float :adjustment
      t.integer :daytime_indicator
    end
    create_citier_view(TransmissionLossAdjustmentDataElement)
  end

  def self.down
    drop_citier_view(TransmissionLossAdjustmentDataElement)
    drop_table :transmission_loss_adjustment_data_elements
  end
end
