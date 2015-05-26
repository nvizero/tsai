class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def confirm_logged_in

      unless session[:user_id]
        flash[:notice] = "會員專區請先登入!"
        redirect_to(:controller => 'login', :action => 'login_form')
        return false # halts the before_action
      else
        return true
      end

  end

  def get_base_data
    @head_msgs = Msg.top.live
    @mid_msgs = Msg.mid.live
  end


end
