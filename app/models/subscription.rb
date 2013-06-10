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

  # Useful method to go through each subscription and place it into the queue.
  def self.queue_all_for_evaluation
    find(:all).each do |subscription|
      subscription.queue_for_evaluation
    end
  end

  # Place this instance of a subscription into the queuing mechanism for
  # evaluation.
  def queue_for_evaluation
    SubscriptionEvalutaionQueue.append_subscription id
  end
  
  # Check whether the two ends of this subscription are different or
  # identical. If the are different instigate an update.
  def evaluate
    source_value = source_link.evaluate
    destination_value = destination_link.evaluate

    logger.debug { source_value }
    logger.debug { destination_value }

    # Mismatch identified.    
    if source_value != destination_value then
      
      # Now choose how to deal with this: read, write or synchronise.
      if subscription_type.name == "Read" then
        synchronise false
      elsif subscription_type.name == "Write" then
        synchronise true
      else
        logger.debug { "Creating 'Message Data Element'" }
        message = SubscriptionMessageDataElement.new(:subscription_id => id,
                              :message_id => Message.find_by_name('Subscription Error').id,
                              :hidden => 0,
                              :data_element_collection_id => DataElementCollection.find_by_name('Messages').id,
                              :ready_to_archive => 0,
                              :globe_id => source_link.data_element.globe_id)
        message.evaluate
  
        # If we are dealing with a discrepency between two globes then both globes will
        # be notified of the change.
        logger.debug "subscription.evaluate.1"
        if (source_link.data_element.globe_id != destination_link.data_element.globe_id) #&& subscription_type.name = 'Synchronise'
          logger.debug "subscription.evaluate.2"
          logger.debug destination_link.data_element.globe_id.to_s
          
          # Construct the message for the other side.
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
