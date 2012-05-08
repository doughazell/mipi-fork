class CreateTransmissionLossAdjustmentDataElements < ActiveRecord::Migration
  def self.up
    create_table :transmission_loss_adjustment_data_elements do |t|
      t.datetime :month
      t.string :unit
      t.float :adjustment

      t.timestamps
    end
  end

  def self.down
    drop_table :transmission_loss_adjustment_data_elements
  end
end
