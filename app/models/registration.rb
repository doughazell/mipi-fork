# @author Paul Long
class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :globe
  
  def self.viewable(user_id)
    where(:user_id => user_id)
  end
end
