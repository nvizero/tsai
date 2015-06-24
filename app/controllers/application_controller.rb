class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  Time.zone = "Taipei"

  def get_self_url
     request.original_url.split('/')
  end


  def user_to_ar
     users = User.all

     urs = []
     users.each do |ur|
       urs[ur.id] = ur.name
     end

     return urs

  end

  #權限判斷
  def jadge_access jadge_str

    if session[:user["access"]] == 'all'
      # render :text => "#{self.get_self_url[3]} -- GG"
    else

      # if jadge_str in session[:user["access"]]
        jadge_flag = false

        @a_str = ''
        session[:user["access"]].split(',').each do |ac|
          if ac == jadge_str
            jadge_flag = true
          end
        end

        if jadge_flag == false
          flash[:notice] = "您的權限不足!!"
          redirect_to(:controller => 'dashboard', :action => 'main')
          return false # halts the before_action
        end

    end

  end

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


  #vip or admin or normal
  def user_vip_access

      cdi = []
      if session[:vip_access] =='VIP'
        UserBelong.where(:belong_user_id =>session[:user_id] ).each do |ubi|
            if !ubi.id.nil?
                cdi[cdi.count] = ubi.user_id
            end
        end

        cdi[cdi.count] = session[:user_id]

      elsif session[:vip_access] =='admin'
        
        cdi = []

      elsif session[:vip_access] =='normal'

        cdi[cdi.count] = session[:user_id]
      end



      return cdi
  end

end
