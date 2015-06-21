class ProductOrdersController < ApplicationController
  before_action :set_product_order, only: [:show, :edit, :update, :destroy]

  before_action :set_title

  layout "admin"
  #取得一些基本資訊
  before_action :get_base_data
  #要登入
  before_action :confirm_logged_in

  def set_title
    @title = ['main1'=>'訂單', 'main2'=>'product_orders','sub1'=>'訂單' , 'sub2'=>'product_orders']
  end

  # GET /product_orders
  # GET /product_orders.json
  def index

    @uc = Member.all.count
    @os = OrderState.all.count
    ProductOrder.all.each do |po|
      po.state = 'Y'
      po.member_id = rand(1...@uc)
      po.order_state_id = [1 , rand(4...8)].sample
      po.save
    end

    @users_a = self.user_to_ar
    @flag = params[:state]

    if @flag=='Y'
      @product_orders = ProductOrder.live.page params[:page]
    elsif @flag=='N'
      @product_orders = ProductOrder.stoped.page params[:page]
    else
      @flag='N'
      @product_orders = ProductOrder.live.page params[:page]
    end


  end

  # GET /product_orders/1
  # GET /product_orders/1.json
  def show
  end

  # GET /product_orders/new
  def new
    @product_order = ProductOrder.new
  end

  # GET /product_orders/1/edit
  def edit
  end

  # POST /product_orders
  # POST /product_orders.json
  def create
    @product_order = ProductOrder.new(product_order_params)
    @product_order.create_user_id = session[:user_id]
    respond_to do |format|
      if @product_order.save
        format.html {
          flash[:notice]  = '新增訂單成功'
          redirect_to :controller => 'product_orders' , :action =>'index'
        }
        format.json { render action: 'show', status: :created, location: @product_order }
      else
        format.html { render action: 'new' }
        format.json { render json: @product_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_orders/1
  # PATCH/PUT /product_orders/1.json
  def update
    respond_to do |format|
      @product_order.modify_user_id = session[:user_id]
      if @product_order.update(product_order_params)
        format.html {
          flash[:notice]  = '修改訂單成功'
          redirect_to :controller => 'product_orders' , :action =>'index'
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_orders/1
  # DELETE /product_orders/1.json
  def destroy



    @product_order.stoped_at = DateTime.now
    @product_order.stop_user_id = session[:user_id]
    @product_order.state='N'
    @product_order.save

    respond_to do |format|
      format.html { redirect_to product_orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_order
      @product_order = ProductOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_order_params
      params.require(:product_order).permit(:code, :order_state_id, :member_id, :state)
    end
end
