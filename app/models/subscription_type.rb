# @author Paul Long
class SubscriptionType < ActiveRecord::Base
  has_many :subscriptions
end
