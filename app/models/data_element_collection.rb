# @author Paul Long
class DataElementCollection < ActiveRecord::Base
  has_many :presentations
  has_many :data_elements, :through => :presentations
  belongs_to :data_sheet
  belongs_to :globe
  
  def current_data_element
    data_elements.last
  end
end
