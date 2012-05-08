class SubscriptionEvalutaionQueue < ActiveRecord::Base
  belongs_to :subscription

  def self.evaluate_all
    SubscriptionEvalutaionQueue.find(:all).each do |s|
      s.subscription.evaluate
      s.delete
    end
  end

  def self.append_subscription(subscription_id)
    @record = SubscriptionEvalutaionQueue.find_by_subscription_id(subscription_id)
    if @record.nil?
      @queue_item = SubscriptionEvalutaionQueue.new
      @queue_item.subscription_id = subscription_id
      @queue_item.save
    end
  end
end

