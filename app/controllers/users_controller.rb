class UsersController < ApplicationController
  layout "admin"
  #登入
  before_action :confirm_logged_in
  #設定上面的TITLT
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_title , only: [:new, :index, :show, :edit, :update, :destroy]
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
    @users = User.live.order(:name).page params[:page]
    #User.order(:name).page params[:page]
    @trades = Trade.sorted
  end

  # def cc
  #   render('test_admin')
  # end


  def do_login

    # @mail = params[:email]
    # @address = Digest::SHA256.hexdigest params[:address]+'tsai'
    #
    # @is_login = User.where(:email=>@mail , :address=>@address).first
    #
    # render('type')
  end



  def login
    @table_title = '使用者登入'
    @title = ['main1'=>'登入', 'LOGIN'=>'Users','sub1'=>'首頁' , 'sub2'=>'登入']
    @user = User.new
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @trades = Trade.sorted
    @sotre_area = StoreArea.all
  end

  # GET /users/1/edit
  def edit
    @trades = Trade.sorted
    @sotre_area = StoreArea.all
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|

      if params[:password] == params[:re_password]

          if @user.save

             #密碼
             #@user.password = Digest::MD5.hexdigest( params[:password].to_s )
             @user.password = ''
             #壯態
             @user.state = 'Y'
             @user.save

             @user.password = Digest::SHA256.hexdigest params[:password].to_s.rstrip.lstrip
             @user.save


            format.html { redirect_to @user, notice: 'User was successfully created.' }
            format.json { render action: 'show', status: :created, location: @user }
          else
            format.html { render action: 'new' }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end

      else

        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }

      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DEadminE /users/1
  # DEadminE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
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
      params.require(:user).permit(:email, :company_address,:role_id, :name,  :boss, :serial_code , :tel,
                                    :send_address,  :check_date, :password, :re_password,
                                  :forget_password, :text,   :trade_id, :store_area_id)

    end

end
