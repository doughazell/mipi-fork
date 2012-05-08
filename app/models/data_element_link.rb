# @author Paul Long
class DataElementLink < ActiveRecord::Base
  has_many :subscriptions
  has_many :data_element_links, :through => :subscriptions
  
  belongs_to :data_element
  
#  has_many :data_element_links, :foreign_key => "source_link_id", :through => :subscriptions
#  has_many :data_element_links, :foreign_key => "destination_link_id", :through => :subscriptions
  def evaluate(delimiter = ' ')
    if (attribute_name != "[ALL]") then
      @values = Array.new
      attribute_name.split(delimiter).each do |attribute_name|
        @value = data_element[attribute_name]
        if (@value.presence) then
          @values << @value 
        end
      end
      @values.join(delimiter)
    end
  end
  
  def update_links(new_id)
#    data_element_id = new_id
    subs = Subscription.retrieve_by_link(id)
    puts "Update Links: "
    puts subs.count.to_s
    puts id.to_s
    subs.each do |s|
      s.queue_for_evaluation
    end
    update_attributes(:data_element_id => new_id)
  end
  
  def update_from_link(other_link)
    #puts "~Source Link..."
    #puts self.id.to_s
    #puts "~Destination Link..."
    #puts other_link.id.to_s
    #
    #puts "-update_from_link"

    changes = Hash.new
    changes[attribute_name] = other_link.evaluate
    #puts changes.to_s
    #puts data_element.globe_id
    #puts other_link.data_element.globe_id
    
    new_data_element = eval("#{other_link.data_element.type}.new(data_element.attributes)")
    new_data_element[attribute_name] = other_link.evaluate

    data_element.update_elements(new_data_element, changes)
  end
end
