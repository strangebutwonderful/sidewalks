class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update]

  respond_to :html, :json

  def show
    @user = User.find(params[:id])
    @noises = @user.noises.limit(10)

    respond_with(@user, @noises)
  end

  def edit
    @user = User.find(params[:id])
    authorize! :update, @user

    respond_with(@user)
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user

    if @user.update_attributes(user_params)
      flash[:notice] = 'User was successfully updated.'
    end

    redirect_to :root
  end


  private

  def user_params
    params.require(:user).permit(:email)
  end


end
