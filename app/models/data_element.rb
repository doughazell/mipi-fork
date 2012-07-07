# @author Paul Long
class DataElement < ActiveRecord::Base
  @@historical_retention = true

  belongs_to :user
  belongs_to :data_element_collection, :class_name => "DataElementCollection"
  belongs_to :globe

  has_many :data_element_links
  
  acts_as_cities

  def compare_element(new_data_element)
      comp1 = Hash.new
      comp1 = attributes
      comp1.delete('id')
      comp1.delete('created_at')
      comp1.delete('updated_at')
  
      comp2 = Hash.new
      comp2 = new_data_element.attributes
      comp2.delete('id')
      comp2.delete('created_at')
      comp2.delete('updated_at')
  
      puts "-------------------"
      puts comp1.to_s
      puts comp2.to_s
    
      comp1.eql?(comp2)
  end

  def update_elements(new_data_element, values)

    if (@@historical_retention)
      if !compare_element(new_data_element) then
        puts "SAVING..."
        new_data_element.created_at = Time.now
        new_data_element.updated_at = new_data_element.created_at
        new_data_element.save
        
        puts "~Number of Links that need to be updated..."
        puts data_element_links.count.to_s
        data_element_links.each do |link|
          link.update_links new_data_element.id
        end
      else
        puts "NOT SAVING..."
      end
    else
      update_attributes(values)
    end
    
  end

  def set(column_name, value)
    var_name = "@#{column_name}"
    self.instance_variable_set(var_name, value)
  end
  
  def self.user_column_data
    column_names - DataElement.column_names
  end
  
  def self.seek_collections_by_globe(globe_id)
    # This will become a really inefficient way of determining the collections.
    data_elements = DataElement.find_all_by_globe_id(globe_id)
    data_element_collections = data_elements.uniq { |x| x.data_element_collection_id }
#    results = data_element_collections.each { |x| x.data_element_collection_id }
  end
  
  def return_non_base_attributes
#    if (!derived_object) then
    derived_object = eval(type).find_by_id(id)
    base_object = DataElement.find_by_id(id)
#    end
    
    #puts "SELF"
    #puts self
    #puts self.attributes
    #
    #puts "DERIVED"
    #puts derived_object
    #puts derived_object.attributes
    #
    return_attributes = Hash.new
    derived_object.attributes.each { |attribute|
#      puts "#{attribute[0]}, #{attribute[1]}"
      if (!base_object.attributes.include?(attribute[0])) then
        puts "Condition Met"
        puts "#{attribute[0]}, #{attribute[1]}"
        return_attributes[attribute[0]] = attribute[1]
      end
    }
    puts "TEST"
    puts return_attributes
    return_attributes
  end
  
  def to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << eval(type).column_names
      csv << attributes.values_at(*eval(type).column_names)
    end
  end

  def self.default_display_columns
    column_names - (DataElement.column_names)
  end
end

