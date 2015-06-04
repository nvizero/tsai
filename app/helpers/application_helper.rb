module ApplicationHelper

  def s_show

  end

  def appli_helper_access(obj)
    render :text => "#{obj.id}"
    # render :text => user.forget_pas
  end

  #網址第三個
  def get_url_3
    request.original_url.split('/')[3]
  end

  def get_role_access
     Role.find(session[:user_role_id])
  end

  def get_user_access
     session[:user["access"]]
  end

  #判斷權限
  def judgment_access _str

    #判斷是否ALL
    if session[:user["access"]] == 'all'

      return true

    else

      judge_flag = false
      
      session[:user["access"]].split(',').each do |ja|
          if ja.to_s.start_with? _str
            judge_flag = true
          end
      end

      return judge_flag

    end

  end

  #只是顯示
  def show_session
    session[:user["access"]]
  end




end
