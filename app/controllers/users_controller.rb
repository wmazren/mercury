class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "User created"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    # @position_supervisors = User.where(params[:position_supervisor])
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to users_url
  end
  
  def create_reviews
    @users = User.find(params[:user_ids])
    @users.each do |user|    
      @period = Period.find_by_account_id_and_state(user.account_id, 'active').id.to_i
      @review = user.reviews.build(params[:review])
      @review.period_id = @period
      @review.account_id = current_user.account_id
      @review.save
    end
    if @review.save
      flash[:notice] = "Reviews created for all selected users!"
      redirect_to users_path
    else
      redirect_to users_path, alert: 'Unable to create reviews for all selected users!'
    end
  end
end
