class UsersController < ApplicationController
  layout "admin"
  #登入
  before_action :confirm_logged_in

  #設定上面的TITLT
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  #取得一些基本資訊
  before_action :get_base_data
  before_action :set_title

  def comm
    return ['main1'=>'使用者', 'main2'=>'Users','sub1'=>'首頁' , 'sub2'=>'使用者']
  end

  def _construct
    return '人員列表'
  end
  # GET /users
  # GET /users.json
  def index
    @title = self.comm
    # @users = User.order("id desc")
    #分頁
    @users = User.order(:name).page params[:page]
    #User.order(:name).page params[:page]
    @trades = Trade.sorted




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

  # GET /users/new
  def new

    @user = User.new
    @roles = Role.live
    @trades = Trade.sorted
    @sotre_area = StoreArea.all
  end

  # GET /users/1/edit
  def edit

    @roles = Role.all
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
          if params["user"][:password] == params["user"][:re_password]

              if @user.save
                 #流水號
                 self.insert_id_seq  params["user"]["username"]

                 @user.state = 'Y'
                 @user.password = Digest::SHA256.hexdigest @user.password
                 uu = @user

                 UserMailer.new_user(uu).deliver

                 @user.save
                 flash[:notice] = "會員-新增成功!"
                 redirect_to :action=> :index

              else

                @roles = Role.all
                @trades = Trade.sorted
                @sotre_area = StoreArea.all
                render action: 'new'

              end
        else

            flash[:notice] = "密碼與確認密碼必需一致"
            flash[:pas] = "密碼與確認密碼必需一致"

            @roles = Role.all
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

    # render :text =>params

    if @user.update(user_params_update)
      flash[:notice] = "會員更新成功!"
      redirect_to action: "index"
    else
      @roles = Role.all
      @trades = Trade.sorted
      @sotre_area = StoreArea.all
      render action: 'edit'
    end

  end

  # DEadminE /users/1
  # DEadminE /users/1.json
  def destroy

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
                                    :re_password, :prompt, :text,
                                    :trade_id, :store_area_id , :username)

    end

    def user_params_update
      params.require(:user).permit( :email, :company_address, :role_id,
                                    :name,  :boss, :serial_code , :tel,
                                    :send_address,  :check_date,
                                    :prompt, :text,
                                    :trade_id, :store_area_id )

    end

end
