# @author Paul Long
class Subscription < ActiveRecord::Base
  belongs_to :subscription_type
  
  belongs_to :data_element_link
  belongs_to :source_link, :class_name => "DataElementLink"
  belongs_to :destination_link, :class_name => "DataElementLink"
  
  has_many :subscription_message_data_elements
  has_many :subscription_evaluation_queues
  
  attr_accessible :source_link_id, :destination_link_id, :subscription_type_id
  
  def self.find_all_references(data_element, database_column)
    data_element_links = DataElementLink.find_all_by_data_element_id_and_attribute_name(data_element.id, database_column)
    if (!data_element_links.empty?) then
      source_subscriptions = find_all_by_source_link_id(data_element_links)
      destination_subscriptions = find_all_by_destination_link_id(data_element_links)
      source_subscriptions + destination_subscriptions
    end
  end
  
  def self.retrieve_by_link(data_element_link_id)
    source_subscriptions = find_all_by_source_link_id(data_element_link_id)
    destination_subscriptions = find_all_by_destination_link_id(data_element_link_id)
    source_subscriptions + destination_subscriptions
  end
  
  def queue_for_evaluation
    SubscriptionEvalutaionQueue.append_subscription id
  end
  
  def evaluate
    source_value = source_link.evaluate
    destination_value = destination_link.evaluate
    
    puts source_value
    puts destination_value
    
    if source_value != destination_value then
      if subscription_type.name == "Read" then
        synchronise false
      elsif subscription_type.name == "Write" then
        synchronise true
      else
        puts "Creating 'Message Data Element'"
        message = SubscriptionMessageDataElement.new(:subscription_id => id,
                              :message_id => Message.find_by_name('Subscription Error').id,
                              :hidden => 0,
                              :data_element_collection_id => DataElementCollection.find_by_name('Messages').id,
                              :ready_to_archive => 0,
                              :globe_id => source_link.data_element.globe_id)
        message.evaluate
  
        # If we are dealing with a discrepency between two globes then both globes will
        # be notified of the change.
        puts "subscription.evaluate.1"
        if (source_link.data_element.globe_id != destination_link.data_element.globe_id) #&& subscription_type.name = 'Synchronise'
          puts "subscription.evaluate.2"
          puts destination_link.data_element.globe_id.to_s
          other_message = SubscriptionMessageDataElement.new(:subscription_id => id,
                              :message_id => Message.find_by_name('Subscription Error').id,
                              :hidden => 0,
                              :data_element_collection_id => DataElementCollection.find_by_name('Messages').id,
                              :ready_to_archive => 0,
                              :globe_id => destination_link.data_element.globe_id)
          other_message.evaluate
        end
      end
    end
  end
  
  def synchronise(reverse)
    if (reverse == true)
      audit
      source_link.update_from_link(destination_link)
    else
      audit
      destination_link.update_from_link(source_link)
    end
  end
  
  def audit
    message = SubscriptionMessageDataElement.new(:subscription_id => id,
                              :message_id => Message.find_by_name('Data Element Change').id,
                              :hidden => 0,
                              :data_element_collection_id => DataElementCollection.find_by_name('Messages').id,
                              :ready_to_archive => 0,
                              :globe_id => destination_link.data_element.globe_id)
    message.evaluate
#    message.save
  end
end
