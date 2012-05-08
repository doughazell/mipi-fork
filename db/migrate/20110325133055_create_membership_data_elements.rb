class CreateMembershipDataElements < ActiveRecord::Migration
  def self.up
    create_table :membership_data_elements do |t|
      t.string :full_name
      t.string :email_address
      t.date :date_of_birth
      t.string :gender
      t.date :date_of_registration
      t.string :membership_level
      t.boolean :direct_mail_opt_in
      t.boolean :direct_email_opt_in
      t.boolean :third_party_promotion_opt_in
    end
    CreateTheViewForCITIEs(MembershipDataElement)
  end

  def self.down
    DropTheViewForCITIEs(MembershipDataElement)
    drop_table :membership_data_elements
  end
end
