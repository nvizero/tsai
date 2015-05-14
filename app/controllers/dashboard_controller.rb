class DashboardController < ApplicationController

  layout "admin"

  def index
    @users = User.all.count
  end
end
