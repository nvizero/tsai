class LoginController < ApplicationController

  layout "admin"

  #取得一些基本資訊
  before_action :get_base_data

  def do_login
    #eeee
    @username = params[:username].rstrip.lstrip
    @old  = params[:password].rstrip.lstrip
    @check_pas    = Digest::SHA256.hexdigest @old.to_s
    @password = @check_pas
    @is_login = User.where(:username=>@username , :re_password => @old ).first

    if @is_login
      self.set_user_sesssion
      redirect_to(:controller=> 'dashboard' , :action => "index")
    end

    #rebder 'login/do_login'
  end

  def set_user_sesssion
    session[:user_id] = @is_login.id
    session[:user_name] = @is_login.name
  end

  def login_form

    @table_title = '使用者登入'
    @title = ['main1'=>'登入', 'LOGIN'=>'Users','sub1'=>'首頁' , 'sub2'=>'登入']
    @user = User.new

  end


  def forget_pas

    @table_title = '忘記密碼'
    @title = ['main1'=>'忘記密碼', 'LOGIN'=>'Users','sub1'=>'首頁' , 'sub2'=>'忘記密碼']
    @user = User.new

  end

  def do_forget_pas

    @table_title = '忘記密碼'
    @title = ['main1'=>'忘記密碼', 'LOGIN'=>'Users','sub1'=>'首頁' , 'sub2'=>'忘記密碼']

    @ou =  User.where(:username => params[:username]).first

    if @ou
      render 'forget_pas'
    else
      render action: 'forget_pas'
    end



  end

  def advance_pas
    @table_title = '密碼提示'
    @title = ['main1'=>'密碼提示', 'LOGIN'=>'Users','sub1'=>'首頁' , 'sub2'=>'密碼提示']
    @user = User.new
  end

  def do_advance_pas
    @table_title = '密碼提示2'
    @title = ['main1'=>'密碼提示2', 'LOGIN'=>'Users','sub1'=>'首頁' , 'sub2'=>'密碼提示']



    @one =  User.where(:username => params[:username]).first

    if @one
      render 'advance_pas'
    else
      render action: 'advance_pas'
    end
  end

  def logout

    session[:user_id] = nil

    flash[:notice] = "登出成功"
    redirect_to(:controller=> 'login' , :action => "login_form")

  end


end
