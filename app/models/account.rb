class Account < ActiveRecord::Base
  has_many :periods
  has_many :reviews
  has_many :users, :inverse_of => :account, :dependent => :destroy
  
  validates :name, :subdomain, :presence => true, :uniqueness => true
  
  accepts_nested_attributes_for :users
  
  attr_accessible :name, :subdomain, :users_attributes
end
