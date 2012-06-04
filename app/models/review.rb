class Review < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  belongs_to :period
  has_many :goals
  
  before_create :check_open
  
  state_machine :state, :initial => :open do
  end
  attr_accessible :account_id, :final_comments, :period_id, :rating, :state, :subordinate_comments, :supervisor_comments, :user_id
  
  private

  def check_open
    user.reviews.find_by_state("open").nil? ? true : false 
  end
end
