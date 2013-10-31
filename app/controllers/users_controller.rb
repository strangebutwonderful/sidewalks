class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_admin

  respond_to :html, :json

  def index
    @users = User.all

    respond_with @users
  end

  def show
    @user = User.find(params[:id])

    respond_with @user
  end

  def edit
    @user = User.find(params[:id])

    respond_with @user
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
    end

    respond_with @user
  end

end
