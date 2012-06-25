class Account < ActiveRecord::Base
  has_many :periods
  has_many :reviews
  has_many :users, :inverse_of => :account, :dependent => :destroy
  
  validates :name, :subdomain, :presence => true, :uniqueness => true
  validates_format_of :subdomain, with: /\A[A-Za-z0-9-]+\Z/, message: "must be lowercase alphanumerics only"
  validates_length_of :subdomain, maximum: 32, message: "exceeds maximum of 32 characters"
  # validates_exclusion_of :subdomain, in: ['www', 'mail', 'ftp'], message: "is not available"
  
  after_create :decrement_quota_count
  
  accepts_nested_attributes_for :users
  
  attr_accessible :name, :subdomain, :user_limit, :activated_at, :users_attributes
  
  RESERVED_SUBDOMAINS = %w(
    www manage admin assets files mail docs calendar sites
    ftp git ssl support status blog api staging demo lab
  )
  validates_exclusion_of :subdomain, :in => RESERVED_SUBDOMAINS,
                         :message => "Subdomain %{value} is reserved."
  
  private
  
  def decrement_quota_count
    self.decrement! :user_limit
  end
end
