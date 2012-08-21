# @author Paul Long
class SubscriptionMessageDataElement < MessageDataElement
  acts_as_cities
  
  belongs_to :subscription

  attr_accessible :hidden, :message_id, :message_text, :subscription_id
  
  # @return String
  def evaluate
    source_value = subscription.source_link.evaluate
    destination_value = subscription.destination_link.evaluate
    template = Liquid::Template.parse(message.definition)
    self.message_text = template.render('source_value' => source_value, 'destination_value' => destination_value)
    save
    self.message_text
  end
  
  # @Array Returns a list of SubscriptionMessageDataElements that are visible and 
  def self.find_active_violations(subscriptions)
    SubscriptionMessageDataElement.find_all_by_subscription_id_and_hidden(subscriptions, 0)
  end
end
