# @author Paul Long
class Globe < ActiveRecord::Base
  acts_as_tree
  
  validates :name, :presence => true
  validates :globe_reference, :presence => true
  validates :globe_reference, :format => { :with => /\A[a-zA-Z]+\z/,
                :message => "Only letters allowed" }
  
  belongs_to :user
  has_many :profiles, :dependent => :destroy
  has_many :data_elements, :dependent => :destroy
  has_many :registrations, :dependent => :destroy
  has_many :users, :through => :registrations
  has_many :data_element_collections
  
  attr_accessible :id, :name, :globe_reference, :parent_id, :security, :created_at, :updated_at
  
  scope :top_level, where(:parent_id => nil)

  accepts_nested_attributes_for :profiles, :allow_destroy => true
end
