# @author Paul Long
class DataElement < ActiveRecord::Base
  acts_as_cities

  @@historical_retention = true

  belongs_to :user
  belongs_to :data_element_collection, :class_name => "DataElementCollection"
  belongs_to :globe

  has_many :data_element_links
  
  DEFAULT_VALUE = [:name, :version]

  def friendly_name
    name
  end
  
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

  def update_elements(retain_data_element, values)

    if (@@historical_retention)
      if !compare_element(retain_data_element) then
        puts "SAVING..."
#        created_at = Time.now
#        version = retain_data_element.version + 1

        save
        retain_data_element.save
        
#        puts "~Number of Links that need to be updated..."
#        puts data_element_links.count.to_s
#        data_element_links.each do |link|
#          link.update_links new_data_element.id
#        end
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
    derived_object = eval(type).find_by_id(id)
    base_object = DataElement.find_by_id(id)
    
    return_attributes = Hash.new
    derived_object.attributes.each { |attribute|
      if (!base_object.attributes.include?(attribute[0])) then
        return_attributes[attribute[0]] = attribute[1]
      end
    }
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
  
#  def to_xml(options = {})
##    to_csv
#    output = ""
#    eval(type).column_names.each do |column|
#      puts "#{type}.#{column}"
#      if (column == "id") then
#        output = output + "<id value='#{id}' />"
#      else
#        output = output + eval("#{column}.to_xml")
#        if (column[-3,3] == '_id')
#          foreign_key = column[0..column.length - 4]
#          output = output + eval("#{foreign_key}.to_xml")
#        end
#      end
#    end
#    puts output
#    output
#  end
  
  def self.find_or_initialize_master_by_name(name_criteria)
    puts name_criteria
#    obj = find(:all, :conditions => ["name = ?", name_criteria], :order => 'updated_at DESC').first
    obj = find(:all, :conditions => ["name = ?", name_criteria], :order => 'version DESC').first
    if (obj.nil?)
      obj = new
    end
    obj
  end
end

