class Admin::ErrorsController < Admin::AdminController

  # GET /admin/errors
  def index
    # throw an exception to test exception handling on server
    raise Exception.new "Don't worry, this one was on purpoise ;)"
  end
end
