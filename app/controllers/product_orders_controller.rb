class ProductOrdersController < ApplicationController
  before_action :set_product_order, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  before_action :set_title
  before_action :set_product_date

  layout "admin"
  #取得一些基本資訊
  before_action :get_base_data
  #要登入
  before_action :confirm_logged_in
  helper_method :sort_column, :sort_direction

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
    @users=[]
    User.all.each do |ur|
        @users[ur.id] = ur.name
    end

    @mems  = Member.all.count
    @os    = OrderState.all.count

    # 換

    # ProductOrder.all.each do |po|
      # po.confirm_order = ''
      # po.state = 'Y'
      # po.member_id = rand(1...@mems)
      # po.create_user_id = rand(1...4)
      # po.order_state_id = rand(1...@os)
      # po.save
      # po.delete
    # end
    @vip_access = user_vip_access
    @users_a = self.user_to_ar
    @flag = params[:state]

    if @flag=='Y'
      @product_orders = ProductOrder.vip_access(@vip_access , session)
                                    .live.order(sort_column + " " + sort_direction)
                                    .page params[:page]
    elsif @flag=='N'
      @product_orders = ProductOrder.vip_access(@vip_access , session)
                                    .stoped
                                    .order(sort_column + " " + sort_direction)
                                    .page params[:page]
    else
      @flag='N'
      @product_orders = ProductOrder.vip_access(@vip_access , session)
                                    .live
                                    .order(sort_column + " " + sort_direction)
                                    .page params[:page]
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
    # logger.info  "#{params}"

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


  def wat_orders
    @title  = ['main1'=>'待出貨明細', 'main2'=>'wait orders','sub1'=>'待出貨明細' , 'sub2'=>'wait orders']
    @mems   = Member.all.count
    @os     = OrderState.all.count

    #換
    # ProductInOut.all.each do |po|
    #     if  po.in_or_out == 'add'
    #         po.is_finish = 'N'
    #         po.save
    #     else
    #         po.delete
    #     end
    # end

    @vip_access = user_vip_access
    @users_a = self.user_to_ar
    @flag = params[:state]

    if @flag=='Y'
      @product_orders = ProductOrder.vip_access(@vip_access , session).live.order(sort_column + " " + sort_direction).where(:confirm_order=>'Y').page params[:page]
    elsif @flag=='N'
      @product_orders = ProductOrder.vip_access(@vip_access , session).stoped.order(sort_column + " " + sort_direction).where(:confirm_order=>'Y').page params[:page]
    else



      @flag='N'

      # @product_orders = ProductOrder.vip_access(@vip_access , session).live.order(sort_column + " " + sort_direction).where(:confirm_order=>'Y').page params[:page]
      # @product_orders = ProductOrder.joins(:category)
      # Client.joins('LEFT OUTER JOIN addresses ON addresses.client_id = clients.id')

      @product_orders = ProductOrder.vip_access(@vip_access , session).live.order(sort_column + " " + sort_direction).where(:confirm_order=>'Y').page params[:page]

    end

    render 'wait_orders'
  end



  def sale_compare

    @pars = params
    @title  = ['main1'=>'對帳單查詢', 'main2'=>'wait orders','sub1'=>'對帳單查詢' , 'sub2'=>'wait orders']
    @mems   = Member.all.count
    @os     = OrderState.all.count

    #換
    @vip_access = user_vip_access
    @users_a = self.user_to_ar
    @flag = params[:state]

    if @flag=='Y'
        @product_orders = ProductOrder.vip_access(@vip_access , session).live.order(sort_column + " " + sort_direction).where(:confirm_order=>'Y').page params[:page]
    elsif @flag=='N'
        @product_orders = ProductOrder.vip_access(@vip_access , session).stoped.order(sort_column + " " + sort_direction).where(:confirm_order=>'Y').page params[:page]
    else



      @flag='N'
      @sql_str = []
      a_str = ''

      #
      if !@pars[:date_start].nil? && @pars[:date_start].to_s.length > 0
        a_str = ' `product_orders`.`order_day` >= '+" '#{@pars[:date_start].strip}' "
        @sql_str.push(a_str)
      end

      if !@pars[:date_end].nil? && @pars[:date_end].to_s.length > 0
        a_str = ' `product_orders`.`order_day` <= '+" '#{@pars[:date_end].strip}' "
        @sql_str.push(a_str)
      end

      if !@pars[:order_number].nil? && @pars[:order_number].to_s.length > 0
        a_str = ' `product_orders`.`code` like '+"'%"+"#{@pars[:order_number].strip}"+"%'"
        @sql_str.push(a_str)
      end

      if !@pars[:member_name].nil? && @pars[:member_name].to_s.length > 0
        a_str = ' members.name like '+"'%"+ "#{@pars[:member_name].strip}"+ "%' "
        @sql_str.push(a_str)
      end

      if !@pars[:product_name].nil? && @pars[:product_name].to_s.length > 0
        a_str = ' wait_orders.product_name like '+" '%"+"#{@pars[:product_name].strip}" +"%' "
        @sql_str.push(a_str)
      end


      fl=true
      @sql_schema = ''
      @sql_str.each do |sqls|
          if fl
              @sql_schema +=  " #{sqls} "
              fl=false
          else
              @sql_schema +=  " AND #{sqls} "
          end
      end



      #如果搜尋條件有的話
      if  @sql_schema.to_s.length > 2

          @pos1 = ProductOrder.select("* , wait_orders.num as num , wait_orders.price as price , wait_orders.total as total , wait_orders.product_name as product_name")
                             .select("wait_orders.product_id as product_id")
                             .joins(" JOIN `wait_orders` ON `product_orders`.`code` = `wait_orders`.`code`")
                             .joins(" JOIN `members` ON `product_orders`.`member_id` = `members`.`id`")
                             .vip_access(@vip_access , session)
                             .where(@sql_schema)

          @pos = @pos1.page params[:page]

          @all_pos_total = 0
          @this_page_total = 0

          @pos1.each do |a_po|
             @all_pos_total       += a_po.total
          end

          @pos.each do |t_po|
             @this_page_total       += t_po.total
          end

      else

        @pos1 = ProductOrder.select("* , wait_orders.num as num , wait_orders.price as price , wait_orders.total as total , wait_orders.product_name as product_name")
                           .select("wait_orders.product_id as product_id")
                           .joins(" JOIN `wait_orders` ON `product_orders`.`code` = `wait_orders`.`code`")
                           .joins(" JOIN `members` ON `product_orders`.`member_id` = `members`.`id`")
                           .vip_access(@vip_access , session)


        @pos = @pos1.page params[:page]

        @all_pos_total = 0
        @this_page_total = 0

        @pos1.each do |a_po|
           @all_pos_total       += a_po.total
        end

        @pos.each do |t_po|
           @this_page_total       += t_po.total
        end

      end

    end

  end


  def sale_list



    @pars = params
    @title  = ['main1'=>'銷售額查詢', 'main2'=>'sale list','sub1'=>'銷售額查詢' , 'sub2'=>'sale list']
    @mems   = Member.all.count
    @os     = OrderState.all.count

    #換
    @vip_access = user_vip_access
    @users_a = self.user_to_ar
    @flag = params[:state]

    if @flag=='Y'
        @product_orders = ProductOrder.vip_access(@vip_access , session).live.order(sort_column + " " + sort_direction).where(:confirm_order=>'Y').page params[:page]
    elsif @flag=='N'
        @product_orders = ProductOrder.vip_access(@vip_access , session).stoped.order(sort_column + " " + sort_direction).where(:confirm_order=>'Y').page params[:page]
    else



      @flag='N'
      @sql_str = []
      a_str = ''

      #
      if !@pars[:date_start].nil? && @pars[:date_start].to_s.length > 0
        a_str = ' `product_orders`.`order_day` >= '+" '#{@pars[:date_start].strip}' "
        @sql_str.push(a_str)
      end

      if !@pars[:date_end].nil? && @pars[:date_end].to_s.length > 0
        a_str = ' `product_orders`.`order_day` <= '+" '#{@pars[:date_end].strip}' "
        @sql_str.push(a_str)
      end

      if !@pars[:order_number].nil? && @pars[:order_number].to_s.length > 0
        a_str = ' `product_orders`.`code` like '+"'%"+"#{@pars[:order_number].strip}"+"%'"
        @sql_str.push(a_str)
      end

      if !@pars[:member_name].nil? && @pars[:member_name].to_s.length > 0
        a_str = ' members.name like '+"'%"+ "#{@pars[:member_name].strip}"+ "%' "
        @sql_str.push(a_str)
      end

      if !@pars[:product_name].nil? && @pars[:product_name].to_s.length > 0
        a_str = ' wait_orders.product_name like '+" '%"+"#{@pars[:product_name].strip}" +"%' "
        @sql_str.push(a_str)
      end


      fl=true
      @sql_schema = ''
      @sql_str.each do |sqls|
          if fl
              @sql_schema +=  " #{sqls} "
              fl=false
          else
              @sql_schema +=  " AND #{sqls} "
          end
      end



      #如果搜尋條件有的話
      if  @sql_schema.to_s.length > 2

          @pos1 = ProductOrder.select("* , wait_orders.num as num , wait_orders.price as price , wait_orders.total as total , wait_orders.product_name as product_name")
                             .joins(" JOIN `wait_orders` ON `product_orders`.`code` = `wait_orders`.`code`")
                             .joins(" JOIN `members` ON `product_orders`.`member_id` = `members`.`id`")
                             .vip_access(@vip_access , session)
                             .where(@sql_schema)


          @pos = @pos1.page params[:page]

          @all_pos_total = 0
          @this_page_total = 0

          @pos1.each do |a_po|
             @all_pos_total       += a_po.total
          end

          @pos.each do |t_po|
             @this_page_total       += t_po.total
          end

      else
          @pos1 = ProductOrder.vip_access(@vip_access , session).select("* , wait_orders.num as num , wait_orders.price as price , wait_orders.total as total , wait_orders.product_name as product_name")
                             .joins(" JOIN `wait_orders` ON `product_orders`.`code` = `wait_orders`.`code`")
                             .joins(" JOIN `members` ON `product_orders`.`member_id` = `members`.`id`")
                             .vip_access(@vip_access , session)


          @pos = @pos1.page params[:page]

          @all_pos_total    = 0
          @this_page_total  = 0

          @pos1.each do |a_po|
             @all_pos_total       += a_po.total
          end

          @pos.each do |t_po|
             @this_page_total       += t_po.total
          end

      end
     end


  end

  private


    def sort_column
      ProductOrder.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_product_order
      @product_order = ProductOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_order_params
      params.require(:product_order).permit(:code, :order_state_id, :member_id, :state)
    end


end
