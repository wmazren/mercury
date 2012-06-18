class Account < ActiveRecord::Base
  has_many :periods
  has_many :reviews
  has_many :users, :inverse_of => :account, :dependent => :destroy
  
  validates :name, :subdomain, :presence => true, :uniqueness => true
  validates_format_of :subdomain, with: /^[a-z0-9_]+$/, message: "must be lowercase alphanumerics only"
  validates_length_of :subdomain, maximum: 32, message: "exceeds maximum of 32 characters"
  validates_exclusion_of :subdomain, in: ['www', 'mail', 'ftp'], message: "is not available"
  
  accepts_nested_attributes_for :users
  
  attr_accessible :name, :subdomain, :users_attributes
end
