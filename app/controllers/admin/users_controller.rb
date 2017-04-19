class Admin::UsersController < Admin::AdminController

  def index
    @users = User.explore(params).includes(:locations, :roles).all

    respond_to do |format|
      format.html
    end
  end

  def triage
    @users = User.where_needs_triage.includes(:locations, :roles).all

    respond_to do |format|
      format.html { render :index }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  # GET /admin/user/new
  # GET /admin/user/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html
    end
  end

  # GET /admin/user/edit
  def edit
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  # POST /admin/users
  def create
    if Sidewalks::Informants::Twitter.client.
       follow(params[:user][:provider_screen_name])

      flash[:notice] = "User was followed."
    end

    redirect_to admin_users_path
  end

  def update
    @user = User.find(params[:id])

    @user.attributes = user_params

    respond_to do |format|
      if @user.save
        format.html do
          redirect_to(
            [:admin, @user],
            notice: "User was successfully updated."
          )
        end
      else
        format.html { render action: "edit" }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :mobile_venues_count)
  end
end
