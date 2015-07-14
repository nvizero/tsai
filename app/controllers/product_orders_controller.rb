class ProductOrdersController < ApplicationController
  before_action :set_product_order, only: [:show, :edit, :update, :destroy]

  before_action :set_title
  before_action :set_product_date

  layout "admin"
  #取得一些基本資訊
  before_action :get_base_data
  #要登入
  before_action :confirm_logged_in

  def set_title
    @title = ['main1'=>'訂單', 'main2'=>'product_orders','sub1'=>'訂單' , 'sub2'=>'product_orders']
  end


  def set_product_date
    @members = Member.live
    @products = Product.live

    # @code_serial = Product.where(:created_at LIKE '%#{Time.now.strftime("%Y-%m-%d")}%'" )
    # Comment.where(:created_at => @selected_date.beginning_of_day..@selected_date.end_of_day)
    # @code_serial = Product.where(:created_at => DateTime.new(2015,6,21)..DateTime.new(2015,6,23) )
    @code_serial = ProductOrder.where(
    'created_at >= :start_days_ago or created_at >= :end_days_ago',
          :start_days_ago  => Time.now.strftime("%Y-%m-%d 00:00:01"),
          :end_days_ago => Time.now.strftime("%Y-%m-%d 23:23:59")
      )
    # :three_days_ago => Time.now - 1.days
  end
  # GET /product_orders
  # GET /product_orders.json
  def index

    @mems = Member.all.count
    @os = OrderState.all.count
    #換
    # ProductOrder.all.each do |po|
    #   po.state = 'Y'
    #   po.member_id = rand(1...@mems)
    #   po.create_user_id = rand(1...4)
    #   po.order_state_id = rand(1...@os)
    #   po.save
    # end
    @vip_access = user_vip_access
    @users_a = self.user_to_ar
    @flag = params[:state]

    if @flag=='Y'
      @product_orders = ProductOrder.vip_access(@vip_access , session).live.page params[:page]
    elsif @flag=='N'
      @product_orders = ProductOrder.vip_access(@vip_access , session).stoped.page params[:page]
    else
      @flag='N'
      @product_orders = ProductOrder.vip_access(@vip_access , session).live.page params[:page]
    end


  end

  # GET /product_orders/1
  # GET /product_orders/1.json
  def show
  end

  # GET /product_orders/new
  def new
      @pay_types = PayType.live
      @product_order = ProductOrder.new
  end

  # GET /product_orders/1/edit
  def edit
      # order_by_products
      @pay_types = PayType.live
      @orderInfos = OrderByProduct.where(:code=>@product_order.code)

      @pro_infos = []
      Product.live.each do |pro|
          @pro_infos[pro.id] = pro.title
      end

  end

  # POST /product_orders
  # POST /product_orders.json
  def create
    render :text =>params
    # @product_order = ProductOrder.new(product_order_params)
    # @product_order.create_user_id = session[:user_id]
    # respond_to do |format|
    #   if @product_order.save
    #     format.html {
    #       flash[:notice]  = '新增訂單成功'
    #       redirect_to :controller => 'product_orders' , :action =>'index'
    #     }
    #     format.json { render action: 'show', status: :created, location: @product_order }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @product_order.errors, status: :unprocessable_entity }
    #   end
    # end
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
    logger.info  "#{params}"

    @product_order.stoped_at    = DateTime.now
    @product_order.stop_user_id = session[:user_id]
    @product_order.state = 'N'
    @product_order.save

    redirect_to action: 'index'
    # respond_to do |format|
    #   format.html { redirect_to product_orders_url }
    #   format.json { head :no_content }
    # end
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
