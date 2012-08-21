# @author Paul Long
class Message < ActiveRecord::Base
  belongs_to :message_severity
  has_many :message_data_elements
  
  attr_accessible :name, :definition, :message_severity_id
end
