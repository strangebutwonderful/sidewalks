class Admin::UsersController < Admin::AdminController

  respond_to :html, :json

  def index
    @users = User.where_search(params).includes(:locations, :roles).all

    respond_with(:admin, @users)
  end

  def show
    @user = User.find(params[:id])

    respond_with(:admin, @user)
  end

  # GET /admin/user/new
  # GET /admin/user/new.json
  def new
    @user = User.new

    respond_with(:admin, @user)
  end

  def edit
    @user = User.find(params[:id])

    respond_with(:admin, @user)
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    if Twitter.follow(params[:user][:provider_screen_name])
      flash[:notice] = 'User was followed.'
    end

    redirect_to admin_users_path
  end  
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
    end

    respond_with(:admin, @user)
  end

end