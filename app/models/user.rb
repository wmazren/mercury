class User < ActiveRecord::Base
  belongs_to :account, :inverse_of => :users
  has_many :reviews
  has_many :periods, :through => :reviews
  has_many :goals
  has_many :updates
  has_many :subordinates, :class_name => "User", :foreign_key => "supervisor_id"
  belongs_to :supervisor, :class_name => "User"
  
  validates :account, :presence => true
  # validates :period, :presence => true
  validates :username, :first_name, :last_name, :presence => true
  validates :username, :uniqueness => true
  
  state_machine :initial => 'active' do
    event 'disable' do
      transition 'active' => 'disabled'
    end
  end
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
                  :username, :first_name, :last_name, :role, :account_id, :state,
                  :position_supervisor, :supervisor_id
  # attr_accessible :title, :body
end
