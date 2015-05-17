class MsgsController < ApplicationController


  layout 'admin'

  before_action :set_msg, only: [:show, :edit, :update, :destroy]
  #取得一些基本資訊
  before_action :get_base_data
  #設定上面的TITLT
  before_action :set_title, only: [:index , :show, :edit, :update, :destroy]


  #取得一些基本資訊
  before_action :get_base_data
  # GET /msgs
  # GET /msgs.json
  def index
    @title = self.comm
    @msgs  = Msg.live

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

    respond_to do |format|
      if @msg.save
        format.html { redirect_to @msg, notice: 'Msg was successfully created.' }
        format.json { render action: 'show', status: :created, location: @msg }
      else
        format.html { render action: 'new' }
        format.json { render json: @msg.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /msgs/1
  # PATCH/PUT /msgs/1.json
  def update
    respond_to do |format|
      if @msg.update(msg_params)
        format.html { redirect_to @msg, notice: 'Msg was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @msg.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /msgs/1
  # DELETE /msgs/1.json
  def destroy
    @msg.destroy
    respond_to do |format|
      format.html { redirect_to msgs_url }
      format.json { head :no_content }
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_msg
      @msg = Msg.find(params[:id])
    end

    def set_title
      @title  = self.comm
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def msg_params
      params.require(:msg).permit(:title, :contetn, :state)
    end
end
