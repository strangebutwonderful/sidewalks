class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_admin  
end
