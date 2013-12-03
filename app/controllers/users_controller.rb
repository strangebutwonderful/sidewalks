class UsersController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html, :json

  def edit
    @user = User.find(params[:id])
    authorize! :update, @user
  
    respond_with(@user)
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
    end

    redirect_to :root
  end

end
