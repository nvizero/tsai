class VerifyTypeMainsController < ApplicationController
  before_action :set_verify_type_main, only: [:show, :edit, :update, :destroy]

  layout "admin"
  #登入
  before_action :confirm_logged_in



  #取得一些基本資訊
  before_action :get_base_data
  before_action :set_title

  # GET /verify_type_mains
  # GET /verify_type_mains.json
  def index

    @users_a = User.all.to_a

    # VerifyTypeMain.all.each do |ad|
    #   ad.state = 'Y'
    #   ad.save
    # end

    self.jadge_access 'verify_type_mains/index'

    @verify_type_mains = VerifyTypeMain.page params[:page]


  end

  # GET /verify_type_mains/1
  # GET /verify_type_mains/1.json
  def show
  end

  # GET /verify_type_mains/new
  def new
    @verify_type_main = VerifyTypeMain.new
  end

  # GET /verify_type_mains/1/edit
  def edit
    @title[0]['main1']='編輯－三證類型主檔'
  end

  # POST /verify_type_mains
  # POST /verify_type_mains.json
  def create
    @verify_type_main = VerifyTypeMain.new(verify_type_main_params)
    @verify_type_main.create_user_id = session[:user_id]

      if @verify_type_main.save
        # format.html {
          redirect_to :action=>'index'
          flash[:notice] = '新增成功'
        # format.json { render action: 'show', status: :created, location: @verify_type_main }
      else
        # format.html {
         render action: 'new'
        #  }
        # format.json { render json: @verify_type_main.errors, status: :unprocessable_entity }
      end
    # end
  end

  # PATCH/PUT /verify_type_mains/1
  # PATCH/PUT /verify_type_mains/1.json

  def update

    @verify_type_main.modify_user_id = session[:user_id]

    if @verify_type_main.update(verify_type_main_params)
        flash[:notice] = "更新成功"
        redirect_to :controller=>'verify_type_mains' ,:action => 'index'
    else
        render action: 'edit'
    end
  end

  # DELETE /verify_type_mains/1
  # DELETE /verify_type_mains/1.json
  def destroy
    # @verify_type_main.destroy
    @verify_type_main.stop_user_id = session[:user_id]
    @verify_type_main.stoped_at = DateTime.now
    @verify_type_main.state = 'N'
    @verify_type_main.save

    respond_to do |format|
      format.html { redirect_to verify_type_mains_url }
      format.json { head :no_content }
    end
  end

  private

    def set_title
      @title  = ['main1'=>'三證類型主檔', 'main2'=>'verify_type_mains','sub1'=>'首頁' , 'sub2'=>'三證類型主檔']
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_verify_type_main
      @verify_type_main = VerifyTypeMain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def verify_type_main_params
      params.require(:verify_type_main).permit(:title, :content)
    end
end
