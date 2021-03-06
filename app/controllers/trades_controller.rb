class TradesController < ApplicationController

  layout "admin"
  #登入
  before_action :confirm_logged_in
  #取得一些基本資訊
  before_action :get_base_data
  #設定上面的TITLT
  before_action :set_title

  before_action :set_trade, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def comm
    return ['main1'=>'交易代碼', 'main2'=>'trades','sub1'=>'首頁' , 'sub2'=>'交易代碼']
  end
  # GET /trades
  # GET /trades.json
  def index

    # Trade.all.each do |zxc|
    #   zxc.state = 'Y'
    #   zxc.save
    # end

    @users_a = self.user_to_ar
    @table_title  = "交易代碼列表"
    # @trades = Trade.page params[:page]

    @flag = params[:state]
    if @flag=='N'
        @trades = Trade.stoped.order(sort_column + " " + sort_direction).page params[:page]

    else
        @trades = Trade.live.order(sort_column + " " + sort_direction).page params[:page]
        @flag='Y'
    end

  end

  # GET /trades/1
  # GET /trades/1.json
  def show
    @table_title  = "新增交易代碼"
  end

  # GET /trades/new
  def new
      @table_title  = "新增交易代碼"
      @trade = Trade.new
  end

  # GET /trades/1/edit
  def edit
  end

  # POST /trades
  # POST /trades.json
  def create

    @trade = Trade.new(trade_params)
    @trade.create_user_id = session[:user_id]
    if @trade.save
      flash[:notice] = "交易碼新增成功!"
      # render :text => @trade.id
      redirect_to :action => :index

    else

      # render action: 'edit'
      
      render action: 'new'
    end

    # respond_to do |format|
    #   if @trade.save
    #     format.html { redirect_to @trade, notice: 'Trade was successfully created.' }
    #     format.json { render action: 'index', status: :created, location: @trade }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @trade.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /trades/1
  # PATCH/PUT /trades/1.json
  def update
    @trade.modify_user_id = session[:user_id]
    if @trade.update(trade_params)
      flash[:notice] = "交易碼更新成功!"
      redirect_to action: "index"
    else
      render action: 'edit'
    end

    # respond_to do |format|
    #   if @trade.update(trade_params)
    #     format.html { redirect_to @trade, notice: 'Trade was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @trade.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DEadminE /trades/1
  # DEadminE /trades/1.json
  def destroy
    @trade.stop_user_id = session[:user_id]
    @trade.stoped_at = DateTime.now
    @trade.state = 'N'
    @trade.save

    respond_to do |format|
      format.html { redirect_to trades_url }
      format.json { head :no_content }
    end
  end

  def del
    @trade.stoped_at = DateTime.now
    @trade.stop_user_id = session[:user_id]
    @trade.state='N'
    @trade.save


    redirect_to '/trades'

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def sort_column
      Trade.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_trade
      @trade = Trade.find(params[:id])
    end

    def set_title
      @title  = self.comm
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_params
      params.require(:trade).permit(:description , :id)
    end
end
