# @author Paul Long
class Message < ActiveRecord::Base
  belongs_to :message_severity
  has_many :message_data_elements
end
