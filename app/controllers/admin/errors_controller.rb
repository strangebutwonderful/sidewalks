class Admin::ErrorsController < Admin::AdminController

  respond_to :html

  # GET /admin/errors
  def index
    raise Exception "Don't worry, this one was on purpoise ;)" 
  end

end
