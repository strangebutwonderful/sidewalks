class Admin::AdminController < ApplicationController
  before_action :authenticate_user_or_redirect_to_root!
  before_action :verify_admin_or_redirect_to_root!
end
