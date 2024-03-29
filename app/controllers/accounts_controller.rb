class AccountsController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create]
  load_and_authorize_resource :except => [:new, :create]
  
  def index
    @accounts = Account.where(:id => current_user.account_id)
  end
  
  def show
    @account = Account.find(params[:id])
  end
  
  def new
    @account = Account.new
    @account.users.build # build a blank user or the child form won't display
  end

  def create
    @account = Account.new(params[:account])
    if @account.save
      flash[:notice] = "Account created"
      redirect_to root_url #redirect to welcome page
    else
      render 'new'
    end
  end

  def edit
    @account = Account.find(params[:id])
  end
  
  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account])
      flash[:notice] = "Successfully updated account."
      redirect_to @account
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    flash[:notice] = "Successfully destroyed account."
    redirect_to accounts_url
  end
end
