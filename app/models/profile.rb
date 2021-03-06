# @author Paul Long
class Profile < ActiveRecord::Base
  belongs_to :globe
  has_many :data_sheets, :dependent => :destroy
  acts_as_list
  
  attr_accessible :id, :name, :globe_id, :position, :created_at, :updated_at
  
  #validates_presence_of :name, :message => "Must specify a Profile Name!"
  validates :globe, :presence => true
  validates :name, :presence => true
  
  accepts_nested_attributes_for :data_sheets, :allow_destroy => true

  def setup_defaults(globe)
    puts "Profile.setup_defaults() START"
    data_sheets.each do |data_sheet|
      data_sheet.setup_defaults(globe, self)
#      data_sheet.save
    end
    puts "Profile.setup_defaults() END"
  end
  
end
