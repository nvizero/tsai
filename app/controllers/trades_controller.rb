class TradesController < ApplicationController

  layout "admin"
  #登入
  before_action :confirm_logged_in
  #設定上面的TITLT
  before_action :set_title , only: [:new, :index, :show, :edit, :update, :destroy]

  before_action :set_trade, only: [:show, :edit, :update, :destroy]


  def comm
    return ['main1'=>'交易代碼', 'main2'=>'trades','sub1'=>'首頁' , 'sub2'=>'交易代碼']
  end
  # GET /trades
  # GET /trades.json
  def index
    @table_title  = "交易代碼列表"
    @trades = Trade.all
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

    respond_to do |format|
      if @trade.save
        format.html { redirect_to @trade, notice: 'Trade was successfully created.' }
        format.json { render action: 'index', status: :created, location: @trade }
      else
        format.html { render action: 'new' }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trades/1
  # PATCH/PUT /trades/1.json
  def update
    respond_to do |format|
      if @trade.update(trade_params)
        format.html { redirect_to @trade, notice: 'Trade was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DEadminE /trades/1
  # DEadminE /trades/1.json
  def destroy
    @trade.delete
    respond_to do |format|
      format.html { redirect_to trades_url }
      format.json { head :no_content }
    end
  end

  def del
    @trade = Trade.find(params[:id])
    @trade.destroy
    redirect_to '/trades'

  end

  private
    # Use callbacks to share common setup or constraints between actions.
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
