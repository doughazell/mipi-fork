class CreateRfuMembershipDataElements < ActiveRecord::Migration
  def self.up
    create_table :rfu_membership_data_elements do |t|
      t.string :rfu_team_supported
    end
    create_citier_view(RfuMembershipDataElement)
  end

  def self.down
    drop_citier_view(RfuMembershipDataElement)
    drop_table :rfu_membership_data_elements
  end
end
