class LoginController < ApplicationController

  layout "admin"

  #取得一些基本資訊
  before_action :get_base_data

  def do_login
    #eeee
    # @username = params[:username].rstrip.lstrip
    user_data = params[:user]


    @pas= Digest::SHA256.hexdigest user_data["password"].to_s.rstrip.lstrip

    @is_login = User.where(:username => user_data["username"] , :password  => @pas ).first

    # @login_name = User.where(:username => params[:username].to_s.rstrip.lstrip ).first
    #
    # @login_pas = User.where(password:  @password ).first
    # if @is_login
    #
    # end


    if @is_login
        self.set_user_sesssion 
        flash[:notice]  = "#{@is_login.name}您好!登入成功"
        redirect_to(:controller=> 'dashboard' , :action => "main")
    else
        flash[:notice]  = "輸入的帳號密碼有誤！請重新輸入！"
        redirect_to(:controller=> 'login' , :action => "login_form")
    end

  end

  #找到帳號後設定SESSION
  def set_user_sesssion

    session[:user_role_id] = @is_login.role_id
    session[:user_id]   = @is_login.id
    session[:user_name] = @is_login.name

    session[:user["role_id"]] = @is_login.role_id
    session[:user["id"]]   = @is_login.id
    session[:user["name"]] = @is_login.name

    role = Role.find(@is_login.role_id)
    if role.text.to_s == 'all'
        session[:user["access"]] = role.text.to_s
    else

        session[:user["access"]] = ''
        role.text.to_s.split(",").each do |ace|
            #寫入權限到SESSION
            if ace.to_s.length > 0
              aces = Access.find(ace)
              session[:user["access"]] += aces.code.to_s + ','
            end

        end
    end


    # session[:user=>["role_id"]] = @is_login.role_id
    # session[:user=>["id"]]   = @is_login.id
    # session[:user=>["name"]] = @is_login.name
    # session[:user=>["access"]] = "all"

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

    username  =  params["username"]
    email     =  params["email"]

    if email == '' || username == ''

      flash[:notice] = '帳號＆＆EMAIL請勿為空'
      redirect_to :controller => 'login' , :action => 'forget_pas'

    else

        o    = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
        str  = (0...6).map { o[rand(o.length)] }.join
        # user = User.find_by(username: params[:username])
        @ou  =  User.where(:username => params[:username],:email=>params[:email] ).first


        if @ou

            @pas = Digest::SHA256.hexdigest str
            @ou.password = @pas

            @table_title = '忘記密碼'
            @title = ['main1'=>'忘記密碼', 'LOGIN'=>'Users','sub1'=>'首頁' , 'sub2'=>'忘記密碼']

            if @ou
              @ou.forget_pas = str
              @ou.save
              user = @ou
              UserMailer.forget_pas(user , str).deliver
            end

            render 'do_forget_pas'

        else

            flash[:notice] = '找不到帳號&&EMAIL請重新輸入'
            redirect_to :controller => 'login' , :action => 'forget_pas'

        end
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


  #登出
  def logout

    session[:user_id] = nil
    session[:user_role_id] = nil
    session[:user_id]   = nil
    session[:user_name] = nil
    session[:user["role_id"]] = nil
    session[:user["id"]]   = nil
    session[:user["name"]] = nil
    session[:user["access"]] = nil

    flash[:notice] = "登出成功"
    redirect_to(:controller=> 'dashboard' , :action => "index")
  end




end
