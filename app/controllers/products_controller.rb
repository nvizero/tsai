class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :get_verify_type_main, only: [:new, :edit]

  before_action :set_title

  layout "admin"
  #取得一些基本資訊
  before_action :get_base_data

  #要登入
  before_action :confirm_logged_in

  # GET /products
  # GET /products.json
  def index
    @products = Product.live.page params[:page]
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @title[0]['main1'] = "新增產品"
    @product = Product.new
  end

  # GET /products/1/edit
  def edit

  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)


    if @product.save
      flash[:notice] = "產品-新增成功!"
      redirect_to action: "index"
    else
      render action: 'new'
    end
    # respond_to do |format|
    #   if @product.save
    #     format.html { redirect_to @product, notice: 'Product was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @product }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @product.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update

    if @product.update(product_params)
      flash[:notice] = "產品-更新成功!"
      redirect_to action: "index"
    else
      render action: 'edit'
    end
    # respond_to do |format|
    #   if @product.update(product_params)
    #     format.html { redirect_to @product, notice: 'Product was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @product.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    # @product.destroy
    @product.state = 'N'
    @product.save
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private

    def get_verify_type_main
      @verify_type_mains = VerifyTypeMain.live
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def set_title
      @title = ['main1'=>'產品列表', 'main2'=>'products','sub1'=>'首頁' , 'sub2'=>'產品列表']
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :content, :num, :user_id, :verify_type_main_id)
    end
end
