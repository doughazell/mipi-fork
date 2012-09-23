# @author Paul Long
class User < ActiveRecord::Base
  has_many :data_elements
  has_many :data_sheets, :foreign_key => 'created_by'
  has_many :data_sheets, :foreign_key => 'updated_by'
  has_many :registrations
  has_many :globes, :through => :registrations

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  model_stamper

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end
  
end
