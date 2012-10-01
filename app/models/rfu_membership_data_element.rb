# @author Paul Long
class RfuMembershipDataElement < MembershipDataElement
  acts_as_citier

  attr_accessible :full_name, :email_address, :date_of_birth, :gender, :date_of_registration, :membership_level, :direct_mail_opt_in, :direct_email_opt_in, :third_party_promotion_opt_in, :rfu_team_supported
end
