# @author Paul Long
class Presentation < ActiveRecord::Base
  belongs_to :data_sheet
  belongs_to :data_element_collection
  validates_uniqueness_of :data_sheet_id, :scope => :data_element_collection_id
  
  attr_accessible :id, :data_sheet_id, :data_element_collection_id, :created_at, :updated_at
  
  # Calling Presentation again from class method seems to be problematic, creating
  # a call to ActsAsTree. Explicit Presentation reference removed.
  def self.find_other_data_sheets(data_element_collection_id, sheet)
#    all = Presentation.find(:all, :conditions => {:data_element_collection_id => data_element_collection_id})
    all = find(:all, :conditions => {:data_element_collection_id => data_element_collection_id})
    if all.include?(find_by_data_sheet_id_and_data_element_collection_id(sheet.id, data_element_collection_id)) then
      all.delete(find_by_data_sheet_id_and_data_element_collection_id(sheet.id, data_element_collection_id))
    end
    all
  end
  
  def self.find_associated_presentations(globe)
    presentations = []
    profiles = globe.profiles
    profiles.each do |profile|
      profile.data_sheets.each do |data_sheet|
        data_sheet.presentations.each do |presentation|
          presentations.push  presentation
        end
      end
    end
    
    presentations.sort! {|a,b| a.data_sheet.name <=> b.data_sheet.name }
  end
end
