class MsgsController < ApplicationController

  before_action :confirm_logged_in
  
  layout 'admin'

  before_action :set_msg, only: [:show, :edit, :update, :destroy]
  #取得一些基本資訊
  before_action :get_base_data
  #設定上面的TITLT
  before_action :set_title

  before_action :set_state



  #取得一些基本資訊
  before_action :get_base_data
  # GET /msgs
  # GET /msgs.json
  def index

    @title = self.comm
    @msgs  = Msg.page params[:page]

  end

  def comm
    return ['main1'=>'最新消息', 'main2'=>'Msgs','sub1'=>'首頁' , 'sub2'=>'最新消息']
  end

  # GET /msgs/1
  # GET /msgs/1.json
  def show
    @title = ['main1'=>@msg.title, 'main2'=>'','sub1'=>'首頁' , 'sub2'=>@msg.title]
  end

  # GET /msgs/new
  def new
    @msg = Msg.new
  end

  # GET /msgs/1/edit
  def edit
  end

  # POST /msgs
  # POST /msgs.json
  def create
    @msg = Msg.new(msg_params)

    if @msg.save
      flash[:notice] = "最新消息-新增成功!"
      redirect_to action: "index"
    else
      render action: 'new'
    end
    # respond_to do |format|
    #   if @msg.save
    #     format.html { redirect_to @msg, notice: 'Msg was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @msg }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @msg.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /msgs/1
  # PATCH/PUT /msgs/1.json
  def update

    if @msg.update(msg_params)
      flash[:notice] = "最新消息-更新成功!"
      redirect_to action: "index"
    else
      render action: 'edit'
    end
    # respond_to do |format|
    #   if @msg.update(msg_params)
    #     format.html { redirect_to @msg, notice: 'Msg was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @msg.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /msgs/1
  # DELETE /msgs/1.json
  def destroy

    @msg.destroy
    redirect_to :action => :index

  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_msg
      @msg = Msg.find(params[:id])
    end

    def set_title
      @title  = self.comm
    end

    def set_state
      @states  = ['Y','N']
      @places  = ['top','mid']
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def msg_params
      params.require(:msg).permit(:title, :content, :state ,:place)
    end
end
