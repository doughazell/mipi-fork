class CreateRfuMembershipDataElements < ActiveRecord::Migration
  def self.up
    create_table :rfu_membership_data_elements do |t|
      t.string :rfu_team_supported
    end
    CreateTheViewForCITIEs(RfuMembershipDataElement)
  end

  def self.down
    DropTheViewForCITIEs(RfuMembershipDataElement)
    drop_table :rfu_membership_data_elements
  end
end
