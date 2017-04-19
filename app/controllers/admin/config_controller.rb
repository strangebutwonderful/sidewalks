class Admin::ConfigController < Admin::AdminController

  # GET /admin
  def index
    respond_to do |format|
      format.html
    end
  end
end
