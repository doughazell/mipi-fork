# @author Paul Long
class Presentation < ActiveRecord::Base
  belongs_to :data_sheet
  belongs_to :data_element_collection
  validates_uniqueness_of :data_sheet_id, :scope => :data_element_collection_id
  
  attr_accessible :id, :data_sheet_id, :data_element_collection_id, :created_at, :updated_at
  
  def self.find_other_data_sheets(data_element_collection_id, sheet)
    all = Presentation.find(:all, :conditions => {:data_element_collection_id => data_element_collection_id})
    if all.include?(Presentation.find_by_data_sheet_id_and_data_element_collection_id(sheet.id, data_element_collection_id)) then
      all.delete(Presentation.find_by_data_sheet_id_and_data_element_collection_id(sheet.id, data_element_collection_id))
    end
    all
  end
end
