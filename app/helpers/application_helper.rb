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
end
