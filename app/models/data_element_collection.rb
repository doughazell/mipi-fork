# @author Paul Long
class DataElementCollection < ActiveRecord::Base
  has_many :presentations, :dependent => :destroy
  has_many :data_elements, :dependent => :destroy #, :through => :presentations
  belongs_to :data_sheet
  belongs_to :globe

  attr_accessible :id, :name, :security, :archive_criteria, :data_element_type, :page_limit, :historic, :variable_name, :order_by_column, :globe_id, :created_at, :updated_at
  
  def current_data_element
    data_elements.find(:last, :order => "version")
  end
  
  def self.find_top_level_data_elements(type)
    de_all = []
    DataElementCollection.find(:all, :conditions => {:data_element_type => type}).each do |dec|
      de = dec.data_elements.find(:last, :order => 'version')
      if (!de.nil?)
        de_full = type.constantize.find(de.id)
        de_all.push(de_full)
      end
    end
    de_all
  end
end
