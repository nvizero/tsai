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

    # mains = VerifyTypeMain.all
    # mains.each do |min|
    #   min.state = "Y"
    #   min.save
    # end

    @verify_type_mains = VerifyTypeMain.live.page params[:page]


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

    # respond_to do |format|
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
    respond_to do |format|
      if @verify_type_main.update(verify_type_main_params)
        format.html { redirect_to @verify_type_main, notice: 'Verify type main was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @verify_type_main.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /verify_type_mains/1
  # DELETE /verify_type_mains/1.json
  def destroy
    # @verify_type_main.destroy
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
