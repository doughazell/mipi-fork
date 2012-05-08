# @author Paul Long
class MessageSeverity < ActiveRecord::Base
  has_many :messages
end
