class OrderByProductsController < ApplicationController
  before_action :set_order_by_product, only: [:show, :edit, :update, :destroy]

  before_action :set_title

  # layout "admin"
  #取得一些基本資訊
  before_action :get_base_data
  #要登入
  before_action :confirm_logged_in

  
  # GET /order_by_products
  # GET /order_by_products.json
  def index
    @order_by_products = OrderByProduct.all
  end

  # GET /order_by_products/1
  # GET /order_by_products/1.json
  def show
  end

  # GET /order_by_products/new
  def new
    @order_by_product = OrderByProduct.new
  end

  # GET /order_by_products/1/edit
  def edit
  end

  # POST /order_by_products
  # POST /order_by_products.json
  def create
    @order_by_product = OrderByProduct.new(order_by_product_params)

    respond_to do |format|
      if @order_by_product.save
        format.html { redirect_to @order_by_product, notice: 'Order by product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order_by_product }
      else
        format.html { render action: 'new' }
        format.json { render json: @order_by_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_by_products/1
  # PATCH/PUT /order_by_products/1.json
  def update
    respond_to do |format|
      if @order_by_product.update(order_by_product_params)
        format.html { redirect_to @order_by_product, notice: 'Order by product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order_by_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_by_products/1
  # DELETE /order_by_products/1.json
  def destroy
    @order_by_product.destroy
    respond_to do |format|
      format.html { redirect_to order_by_products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_by_product
      @order_by_product = OrderByProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_by_product_params
      params.require(:order_by_product).permit(:product_id, :product_order_id, :num)
    end
end
