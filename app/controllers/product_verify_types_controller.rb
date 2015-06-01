class ProductVerifyTypesController < ApplicationController

  before_action :set_product_verify_type, only: [:show, :edit, :update, :destroy]

  layout 'admin'

  #取得一些基本資訊
  before_action :get_base_data
  #設定上面的TITLT
  before_action :set_title
  #登入
  before_action :confirm_logged_in

  #取得一些基本資訊
  before_action :get_base_data



  # GET /product_verify_types
  # GET /product_verify_types.json
  def index
    @product_verify_types = ProductVerifyType.all
  end

  # GET /product_verify_types/1
  # GET /product_verify_types/1.json
  def show
  end

  # GET /product_verify_types/new
  def new
    @product_verify_type = ProductVerifyType.new
    @verify_type_mains = VerifyTypeMain.live

  end

  # GET /product_verify_types/1/edit
  def edit
    @verify_type_mains = VerifyTypeMain.live
  end

  # POST /product_verify_types
  # POST /product_verify_types.json
  def create
    @product_verify_type = ProductVerifyType.new(product_verify_type_params)

    respond_to do |format|
      if @product_verify_type.save
        format.html { redirect_to @product_verify_type, notice: 'Product verify type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product_verify_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @product_verify_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_verify_types/1
  # PATCH/PUT /product_verify_types/1.json
  def update
    # respond_to do |format|
      if @product_verify_type.update(product_verify_type_params)
        flash[:notice] =  '三證類型修改成功'
        redirect_to :action => 'index'

      else
        render action: 'edit'

      end
    # end
  end

  # DELETE /product_verify_types/1
  # DELETE /product_verify_types/1.json
  def destroy
    @product_verify_type.destroy
    respond_to do |format|
      format.html { redirect_to product_verify_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_verify_type
      @product_verify_type = ProductVerifyType.find(params[:id])
    end

    def set_title
      @title = ['main1'=>'三證類型', 'main2'=>'product_verify_types','sub1'=>'首頁' , 'sub2'=>'三證類型']
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_verify_type_params
      params.require(:product_verify_type).permit(:name, :content,:verify_type_main_id)
    end
end
