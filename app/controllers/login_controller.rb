class LoginController < ApplicationController

  layout "admin"


  def do_login
    #eeee
    @mail = params[:email].rstrip.lstrip
    @old = params[:password].rstrip.lstrip
    @check_pas    = Digest::SHA256.hexdigest @old.to_s
    @password = @check_pas
    @is_login = User.where(:email=>@mail , :re_password => @old ).first
    if @is_login
      self.set_user_sesssion
    end

    #rebder 'login/do_login'
  end

  def set_user_sesssion
    session[:user_id] = @is_login.id
  end

  def login_form

    @table_title = '使用者登入'
    @title = ['main1'=>'登入', 'LOGIN'=>'Users','sub1'=>'首頁' , 'sub2'=>'登入']
    @user = User.new
  end

  def logout

    session[:user_id] = nil
    
    flash[:notice] = "Logged out"
    redirect_to(:controller=> 'login' , :action => "login_form")

  end


end
