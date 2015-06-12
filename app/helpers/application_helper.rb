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
    if session[:user["access"]]

      if session[:user["access"]] == 'all'

        return true

      else

        if session.nil?
          return false
        end

        judge_flag = false
        session[:user["access"]].split(',').each do |ja|
            if ja.to_s.start_with? _str
              judge_flag = true
            end
        end

        return judge_flag

      end

    else
      return true
    end

  end

  #只是顯示
  def show_session
    # session[:user["access"]]
    !session.nil?
  end



  def role_checkbox text , num
    check_flag = false
    text.to_s.split(',').each do |str|
      if str.to_i == num.to_i
        check_flag = true
      end
    end

    if check_flag
      return 'CHECKED'
    else
      return ''
    end
  end


  def check_user_is_new user
    if user.id
      false
    else
      true
    end
  end






  def state_n_show obj , content
    if obj.state == 'N'
      simple_format "#{content}"
    else
      simple_format "#{content}"
    end
  end


  def show_se_user
    
    session[:user_id]
  end




end
