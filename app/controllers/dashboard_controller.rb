class DashboardController < ApplicationController

  layout "admin"
  
  before_action :confirm_logged_in

  def index
    @users = User.all.count
  end
end
