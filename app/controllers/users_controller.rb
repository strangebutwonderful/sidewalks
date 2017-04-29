class UsersController < ApplicationController
  before_action :authenticate_user_or_redirect_to_root!, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @noises = @user.noises.limit(10)

    respond_to do |format|
      format.html
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize! :update, @user

    respond_to do |format|
      format.html
    end
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user

    if @user.update_attributes(user_params)
      flash[:notice] = "User was successfully updated."
    end

    redirect_to :root
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
