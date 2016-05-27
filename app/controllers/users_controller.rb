class UsersController < ApplicationController
  layout "admin"
  #登入
  before_action :confirm_logged_in
   skip_before_filter :verify_authenticity_token, :only => [:update_password]
  #設定上面的TITLT
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  #取得一些基本資訊
  before_action :get_base_data
  before_action :set_title

  helper_method :sort_column, :sort_direction

  def comm
    return ['main1'=>'使用者', 'main2'=>'Users','sub1'=>'首頁' , 'sub2'=>'使用者']
  end

  def _construct
    return '人員列表'
  end
  # GET /users
  # GET /users.json
  def index
    @rolesInfo= Role.all.to_a
    @users_a =  self.user_to_ar
    @title   =  self.comm
    # @users = User.order("id desc")
    #分頁
    StoreArea.all.each do |one|
        one.state = 'Y'
        one.save
        # if ur.vip_access.nil?
        #     ur.vip_access = 'normal'
        #     ur.save
        # end
    end
    @flag = params[:state]
    di = self.user_vip_access
    if @flag=='N'

        @users = User.vip_access(user_vip_access , session).stoped.order(sort_column + " " + sort_direction).page params[:page]

    else

        # @users = User.live.where.not(:id=> di ).order(:id).page params[:page]
        @users = User.vip_access(user_vip_access , session).live.order(sort_column + " " + sort_direction).page params[:page]
        @flag='Y'
    end


    #User.order(:name).page params[:page]
    @trades = Trade.sorted
    @normal_users = User.where(:vip_access =>'normal')

    # 100.times do |uur|
    #     User.create!( :username => "user#{uur}",
    #                   :role_id=> 1 ,
    #                   :re_password => "user#{uur}" ,
    #                   :vip_access => "normal" ,
    #                   :name =>"user#{uur}" ,
    #                   :state=>'Y' ,
    #                   :password=>'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918' ,
    #                   :email =>"user#{uur}@yahoo.com.tw" ,
    #                   :prompt=>'admin123' )
    # end


  end

  # def cc
  #   render('test_admin')
  # end






  def login
    @table_title = '使用者登入'
    @title = ['main1'=>'登入', 'LOGIN'=>'Users','sub1'=>'首頁' , 'sub2'=>'登入']
    @user = User.new
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @roles = Role.live
    @trades = Trade.sorted
  end

  # GET /users/1
  # GET /users/1.json
  def edit_password
    @user = User.find(params[:id])
    # @trades = Trade.sorted
  end

  # GET /users/new
  def new


    @user = User.new
    vip_access

    @user_bs = UserBelong.where(:belong_user_id => @user.id )
    @normal_users = User.where.not(:name =>session[:user_name])

    @roles = Role.live
    @trades = Trade.sorted
    @sotre_area = StoreArea.all
  end

  # GET /users/1/edit
  def edit

    vip_access

    @user_bs = UserBelong.where(:belong_user_id => @user.id )
    @normal_users = User.where.not(:name =>session[:user_name])

    @roles = Role.live
    @trades = Trade.sorted
    @sotre_area = StoreArea.all
  end


  
  # POST /users
  # POST /users.json
  def create
    if false
      render :text => params
    else

        @user = User.new(user_params)
        @user.create_user_id = session[:user_id]
          if params["user"][:password] == params["user"][:re_password]

              if @user.save
                 #流水號
                 insert_id_seq  params["user"]["username"]

                 @user.state = 'Y'
                 @user.password = Digest::SHA256.hexdigest @user.password

                 uu = @user

                 UserMailer.new_user(uu).deliver

                 @user.save
                 flash[:notice] = "會員-新增成功!"
                 redirect_to :action=> :index

              else

                vip_access

                @user_bs = UserBelong.where(:belong_user_id => @user.id )
                @normal_users = User.where.not(:name =>session[:user_name])

                @roles = Role.live
                @trades = Trade.sorted
                @sotre_area = StoreArea.all
                render action: 'new'

              end
        else

            flash[:notice] = "密碼與確認密碼必需一致"
            flash[:pas] = "密碼與確認密碼必需一致"
            vip_access

            @user_bs = UserBelong.where(:belong_user_id => @user.id )
            @normal_users = User.where.not(:name =>session[:user_name])

            @roles = Role.live
            @trades = Trade.sorted
            @sotre_area = StoreArea.all

            render action: 'new'

        end

    end


  end


  def insert_id_seq username

    if username.length.to_i < 8
      namelen=7-username.length.to_i
      fname = ''
      namelen.times{
       fname += '0'
      }
      fname +=username
      IdSeq.create(:pre_id => fname )
    end

  end





  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update


    xx = ''


    # ／render :text =>"#{xx} <br>#{params} "
    @user.modify_user_id = session[:user_id]
    if @user.update(user_params_update)

      if params[:user][:vip_access]=='VIP'

          if !params[:normal_users].nil?

              UserBelong.where(:belong_user_id =>@user.id ).each do |uubg|
                  uubg.destroy
              end

              params[:normal_users].each do |dd|
                  UserBelong.create(:user_id => dd[1] , :belong_user_id =>@user.id )
              end

          end

      elsif params[:user][:vip_access]=='admin'
        #管理員
        UserBelong.where(:belong_user_id =>@user.id ).each do |uubg|
            uubg.destroy
        end

        UserBelong.where(:belong_user_id =>@user.id ).each do |uubg|
            uubg.destroy
        end

      elsif params[:user][:vip_access]=='normal'
        #管理員
        UserBelong.where(:belong_user_id =>@user.id ).each do |uubg|
            uubg.destroy
        end

        UserBelong.create(:user_id => @user.id , :belong_user_id =>@user.id )

      end

      flash[:notice] = "會員更新成功!"
      redirect_to action: "index"
    else
      @normal_users = User.where(:vip_access =>'normal')
      @roles = Role.all
      @trades = Trade.sorted
      @sotre_area = StoreArea.all
      render action: 'edit'
    end




  end




  def update_password

    logger.info  "-sssssss-------#{(params[:passowrd].to_s == params[:re_passowrd].to_s)} , #{params[:re_passowrd].nil?}-#{params[:passowrd].nil?} "

    if (params[:passowrd].to_s == params[:re_passowrd].to_s) && (params[:passowrd].nil?) && (params[:re_passowrd].nil?)

        user = User.find(params[:id])
        user_data = params[:user]
        pas       = Digest::SHA256.hexdigest params[:password].to_s.rstrip.lstrip
        user.password = pas
        user.save

        flash[:notice] = "會員密碼更新成功!"
        redirect_to action: "index"
    else

        flash[:notice] = "輸入錯誤!密碼要相等!"
        redirect_to action: "edit_password", :id =>params[:id]

    end

  end
  # DEadminE /users/1
  # DEadminE /users/1.json
  def destroy

    @user.stop_user_id = session[:user_id]
    @user.stoped_at = DateTime.now
    @user.state = 'N'
    @user.save
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end



  def excel

    users = User.all
    excel  = users.to_xls(:only => [:email, :name,:username],
                          :prepend => [["電子信箱", "姓名",'帳號']] ,
                          :header => false)
    filename = "users-#{Time.now.strftime("%Y%m%d%H%M%S")}.xls"
    send_data(excel, :type => "application/excel; charset=utf-8; header=present", :filename => filename)

  end

  private

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_title
      @title  = self.comm
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit( :email, :company_address,:role_id,
                                    :name,  :boss, :serial_code , :tel,
                                    :send_address,  :check_date, :password,
                                    :re_password, :prompt, :text, :vip_access,
                                    :trade_id, :store_area_id , :username)

    end

    def vip_access
      @access_sel = ['admin'=>'管理者', 'VIP'=>'VIP' , 'normal'=>'一般']
    end

    def user_params_update
      params.require(:user).permit( :email, :company_address, :role_id,
                                    :name,  :boss, :serial_code , :tel,
                                    :send_address,  :check_date,
                                    :prompt, :text, :vip_access,
                                    :trade_id, :store_area_id )

    end

end
