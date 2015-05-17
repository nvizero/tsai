class StoreAreasController < ApplicationController

  layout "admin"
  #取得一些基本資訊
  before_action :get_base_data
  #登入
  before_action :confirm_logged_in
  #設定上面的TITLT
  before_action :set_title , only: [:new, :index, :show, :edit, :update, :destroy]

  before_action :set_store_area, only: [:show, :edit, :update, :destroy]

  # GET /store_areas
  # GET /store_areas.json
  def comm
    return ['main1'=>'庫位', 'main2'=>'store_area','sub1'=>'首頁' , 'sub2'=>'庫位' ]
  end
  # GET /trades
  # GET /trades.json
  def index
    @title  = self.comm
    @table_title = "庫位列表"
    @store_areas = StoreArea.all
  end

  # GET /store_areas/1
  # GET /store_areas/1.json
  def show
  end

  # GET /store_areas/new
  def new
    @table_title = "新增庫位"
    @store_area = StoreArea.new
  end

  # GET /store_areas/1/edit
  def edit
    @table_title = "編輯庫位"
  end

  # POST /store_areas
  # POST /store_areas.json
  def create
    @store_area = StoreArea.new(store_area_params)

    respond_to do |format|
      if @store_area.save
        format.html { redirect_to @store_area, notice: 'Store area was successfully created.' }
        format.json { render action: 'show', status: :created, location: @store_area }
      else
        format.html { render action: 'new' }
        format.json { render json: @store_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /store_areas/1
  # PATCH/PUT /store_areas/1.json
  def update
    respond_to do |format|
      if @store_area.update(store_area_params)
        format.html { redirect_to @store_area, notice: 'Store area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @store_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DEadminE /store_areas/1
  # DEadminE /store_areas/1.json
  def destroy
    @store_area.destroy
    respond_to do |format|
      format.html { redirect_to store_areas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_area
      @store_area = StoreArea.find(params[:id])
    end

    def set_title
      @title  = self.comm
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_area_params
      params.require(:store_area).permit(:area_id, :area_name)
    end
end
