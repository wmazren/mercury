class Progress < ActiveRecord::Base
  belongs_to :goal, :dependent => :destroy
  belongs_to :user
  
  state_machine :state, :initial => 'new' do
    event :progress do
      transition 'new' => 'in progress'
    end
    
    event :complete do
      transition 'in progress' => 'completed'
    end
  end
  
  attr_accessible :goal_id, :percent_complete, :progress_update, :state, :user_id
end
