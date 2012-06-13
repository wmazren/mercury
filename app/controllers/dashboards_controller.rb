class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # authorize_resource

  def index
    @user = User.find_by_id(current_user)
    @account = @user.account_id
    @review = Review.find_by_user_id_and_state(current_user, 'open')
    @review_id = Review.find_by_user_id_and_state(current_user, 'open')
    @period_get = Period.find_by_account_id_and_state(@account, 'open')
        
    if @review.nil?
      @end_date = DateTime.now
    else
      @end_date = @review.period.end_date
    end
    
    if @period_get.nil?
      @period = ''
      @period_start_date = ''
      @period_end_date = ''
    else
      @period = @period_get.name
      @period_start_date = @period_get.start_date
      @period_end_date = @period_get.end_date
    end
    
    @goals = Goal.find_all_by_user_id_and_review_id(current_user, @review_id)
    @goals_total = Goal.find_all_by_user_id_and_review_id(current_user, @review_id).count
    @goals_open = Goal.find(:all, :conditions => { :user_id => current_user, :review_id => @review_id, :state => 'open' }).count
    @goals_closed = Goal.find(:all, :conditions => { :user_id => current_user, :review_id => @review_id, :state => 'closed' }).count
    @goals_in_progress = Goal.find(:all, :conditions => { :user_id => current_user, :review_id => @review_id, :state => 'in progress' }).count
    
  end
end
