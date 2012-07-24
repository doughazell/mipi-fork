# @author Paul Long
class DataElementCollection < ActiveRecord::Base
  has_many :presentations, :dependent => :destroy
  has_many :data_elements, :dependent => :destroy #, :through => :presentations
  belongs_to :data_sheet
  belongs_to :globe
  
  def current_data_element
    data_elements.find(:last, :order => "version")
  end
  
  def self.find_top_level_data_elements(type)
    de_all = []
    DataElementCollection.find(:all, :conditions => {:data_element_type => type}).each do |dec|
      de = dec.data_elements.find(:first, :order => 'updated_at DESC')
      de_all.push(de)
    end
    de_all
  end
end
