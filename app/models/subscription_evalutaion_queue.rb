# SubscriptionEvalutaionQueue provides a list of Subscriptions that need to be
#   evaluated periodically. It seems to provide little more functionality than
#   simply putting an indicator on a Subscription object describing the
#   Subscription as queued or not.
# @author Paul Long
class SubscriptionEvalutaionQueue < ActiveRecord::Base
  belongs_to :subscription

  # This method runs through all records in the class and calls the `evaluate`
  #   routine on the Subscription class. At the end of this the item is deleted
  #   from the queue - this is important, since all queued items appear to be
  #   one-off executions.
  def self.evaluate_all
    SubscriptionEvalutaionQueue.find(:all).each do |s|
      s.subscription.evaluate
      # Uncommented this line since I wasn't sure that the subscription
      # object within the queue should be deleted.
#      s.delete
    end
  end

  # This method will add a Subscription object to the class if it is not
  #   already within the queue.
  def self.append_subscription(subscription_id)
    @record = SubscriptionEvalutaionQueue.find_by_subscription_id(subscription_id)
    if @record.nil?
      @queue_item = SubscriptionEvalutaionQueue.new
      @queue_item.subscription_id = subscription_id
      @queue_item.save
    end
  end
end

