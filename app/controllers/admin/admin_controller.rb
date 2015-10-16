class Admin::AdminController < ApplicationController
  before_filter :authenticate_user_or_redirect_to_root!
  before_filter :verify_admin_or_redirect_to_root!
end
