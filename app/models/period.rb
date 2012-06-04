class Period < ActiveRecord::Base
  belongs_to :account
  has_many :reviews
  has_many :users, :through => :reviews
  
  validates :account_id, :name, :start_date, :end_date, :presence => true
  
  before_create :check_active
  
  attr_accessible :account_id, :end_date, :name, :start_date, :state
  
  state_machine :initial => 'active' do
    event 'close' do
      transition 'active' => 'closed'
    end
  end
  
  private

  def check_active
    account.periods.find_by_state("active").nil? ? true : false 
  end
end
