class ProductInOutsController < ApplicationController

  layout 'admin'

  before_action :set_product_in_out, only: [:show, :edit, :update, :destroy , :out_come_destroy , :in_come_destroy , :in_come_check , :out_come_check]

  before_action :set_title
  before_action :set_in_out_type
  #要登入
  before_action :confirm_logged_in
  #取得一些基本資訊
  before_action :get_base_data
  helper_method :sort_column, :sort_direction
  # GET /product_in_outs
  # GET /product_in_outs.json
  def index


    @users_a = self.user_to_ar
    @flag = params[:steta]
    @product_id = params[:product_id]

    if @product_id
      @product_data = Product.find(:id=>@product_id.to_i)
    end

    @product_in_outs = ProductInOut.vip_access(user_vip_access , session).page params[:page]


  end

  def in_list

    # ProductInOut.all.each do |pio|
    #       if pio.in_or_out == 'reduce'
    #           pio.delete
    #           pio.save
    #       end
    # end

    @title[0]['main1'] = '入庫列表'
    @users_a = self.user_to_ar
    @flag = params[:state]
    @product_id = params[:product_id]

    if @product_id

       @product_data = Product.find(:id=>@product_id.to_i)

    else

       @product_data = Product.all
    end

    if @flag == 'N'
        @product_in_outs = ProductInOut.vip_access(user_vip_access , session).in_come.stoped.order(sort_column + " " + sort_direction).page params[:page]
    elsif @flag == 'Y'
        @product_in_outs = ProductInOut.vip_access(user_vip_access , session).in_come.live.order(sort_column + " " + sort_direction).page params[:page]
    else
        @product_in_outs = ProductInOut.vip_access(user_vip_access , session).in_come.live.order(sort_column + " " + sort_direction).page params[:page]
        @flag='Y'
    end


  end

  def out_list

    @title[0]['main1'] = '出貨列表'
    @users_a = self.user_to_ar
    @flag = params[:state]
    @product_id = params[:product_id]

    if @product_id
      @product_data = Product.find(:id=>@product_id.to_i)
    else
      @product_data = Product.all
    end

    if @flag=='N'
        @product_in_outs = ProductInOut.vip_access(user_vip_access , session).out_come.stoped.order(sort_column + " " + sort_direction).page params[:page]

    elsif @flag=='Y'

        @product_in_outs = ProductInOut.vip_access(user_vip_access , session).out_come.live.order(sort_column + " " + sort_direction).page params[:page]

    else

        @product_in_outs = ProductInOut.vip_access(user_vip_access , session).out_come.live.order(sort_column + " " + sort_direction).page params[:page]
        @flag='Y'
    end

  end
  # GET /product_in_outs/1
  # GET /product_in_outs/1.json
  def show
  end

  # GET /product_in_outs/new
  def new

    @products = Product.all

    today_in_out_count
    @whered = ''
    @i_or_o = params[:type]
    if @i_or_o == 'in'
        @whered = 'add'
    elsif @i_or_o == 'out'
        @whered = 'reduce'
    end

    @store_areas    =  StoreArea.live
    @product_id     =  params[:product_id]
    @in_out_cates   =  InOutType.where(:cate=>@whered)
    @p_in_out_list  =  ProductInOut.live
    @product_data   =  Product.live
    @product_in_out =  ProductInOut.new
  end

  # GET /product_in_outs/1/edit
  def edit

    today_in_out_count
    @whered         =   @product_in_out.in_or_out
    @i_or_o         =   @product_in_out.in_or_out
    @in_out_type    =   params[:type]
    @store_areas    =   StoreArea.live
    @product_id     =   params[:product_id]
    @in_out_cates   =   InOutType.where(:cate=>@product_in_out.in_or_out)

    @product_data   =   Product.live
    @product_id     =   params[:product_id]

    if @product_id
      @product_data = Product.find(:id=>@product_id.to_i)
    else
      @product_data = Product.all
    end
    @p_in_out_list = ProductInOut.live

  end

  # POST /product_in_outs
  # POST /product_in_outs.json
  def create


    # p_i_o = ProductInOut.find( params[:product_in_out][:serial].to_i )
    # render :text => params

    # if true
    #       render :text => params
    # end


    if params[:type] == 'reduce'

            @product_in_out = ProductInOut.new(product_in_out_params)

            p_i_o   = ProductInOut.where(:serial=> params[:product_in_out][:serial].to_s)
            _add    = 0
            _reduce = 0
            nn      = 0

            p_i_o.each do |ppoi|
                 if ppoi.in_or_out == 'add'
                   _add += ppoi.num
                 end

                 if ppoi.in_or_out == 'reduce'
                   _reduce += ppoi.num
                 end
            end

            nn = _add - _reduce

              if (nn.to_i - params[:product_in_out][:num].to_i) <= -1
                    flash[:notice] = '數量不足!或是輸入錯誤!'
                    redirect_to :action => 'new' , :type=>"out"
              else
                    if @product_in_out.save
                          flash[:notice] = "新增成功"
                          redirect_to :controller=>'product_in_outs' , :action=>'out_list'
                    else
                          # flash[:notice] = "errors1"
                          # today_in_out_count
                          # @i_or_o         = params[:type]
                          # @product_id     = params[:product_id]
                          # @product_data   = Product.live
                          # # @product_in_out = ProductInOut.new
                          # redirect_to :controller =>'product_in_outs' , :action=>'new' , :type=>'out'

                          today_in_out_count

                          # @i_or_o         = params[:type]
                          # @product_id     = params[:product_id]
                          # @product_data   = Product.live



                          today_in_out_count
                          @whered         =   @product_in_out.in_or_out
                          @i_or_o         =   @product_in_out.in_or_out
                          @in_out_type    =   params[:type]
                          @store_areas    =   StoreArea.live
                          @product_id     =   params[:product_id]
                          @in_out_cates   =   InOutType.where(:cate=>@product_in_out.in_or_out)

                          @product_data   =   Product.live
                          @product_id     =   params[:product_id]

                          if @product_id
                            @product_data = Product.find(:id=>@product_id.to_i)
                          else
                            @product_data = Product.all
                          end

                          @p_in_out_list = ProductInOut.live

                          render action: 'new' ,:type => @in_out_type
                    end
              end


    elsif params[:type] == 'add'

          @product_in_out = ProductInOut.new(product_in_out_params)
          if @product_in_out.save
                flash[:notice] = "新增成功"
                redirect_to :controller=>'product_in_outs' , :action=>'in_list'
          else
                today_in_out_count

                @i_or_o         = params[:type]
                @product_id     = params[:product_id]
                @product_data   = Product.live



                today_in_out_count
                @whered         =   @product_in_out.in_or_out
                @i_or_o         =   @product_in_out.in_or_out
                @in_out_type    =   params[:type]
                @store_areas    =   StoreArea.live
                @product_id     =   params[:product_id]
                @in_out_cates   =   InOutType.where(:cate=>@product_in_out.in_or_out)

                @product_data   =   Product.live
                @product_id     =   params[:product_id]

                if @product_id
                  @product_data = Product.find(:id=>@product_id.to_i)
                else
                  @product_data = Product.all
                end
                @p_in_out_list = ProductInOut.live

                render action: 'new' ,:type => params[:type]
                # redirect_to :controller =>'product_in_outs' , :action=>'new' , :type=>'in'
          end
    end

  end

  # PATCH/PUT /product_in_outs/1
  # PATCH/PUT /product_in_outs/1.json
  def update
    # respond_to do |format|

      if @product_in_out.update(product_in_out_params)

        flash[:notice] = "編輯成功"

        if @product_in_out.in_or_out == 'add'
            redirect_to :controller=>'product_in_outs' , :action=>'in_list'
        else
            redirect_to :controller=>'product_in_outs' , :action=>'out_list'
        end

        # redirect_to @product_in_out


      else

          today_in_out_count
          @i_or_o = params[:type]
          @product_id = params[:product_id]
          @product_data = Product.live
          render action: 'edit'

          #format.json { render json: @product_in_out.errors, status: :unprocessable_entity }
      end

    # end
  end

  # DELETE /product_in_outs/1
  # DELETE /product_in_outs/1.json
  # def destroy
  #
  #   @product_in_out.stop_user_id = session[:user_id]
  #   @product_in_out.stoped_at = DateTime.now
  #   @product_in_out.state = "N"
  #   @product_in_out.save
  #   # @product_in_out.destroy
  #   respond_to do |format|
  #     format.html { redirect_to product_in_outs_url }
  #     format.json { head :no_content }
  #   end
  # end

  def in_come_check

    # @product_in_out.stop_user_id = session[:user_id]
    # @product_in_out.stoped_at = DateTime.now
    @product_in_out.in_come_check = "Y"
    @product_in_out.save

    redirect_to :action=>'in_list'

  end

  def out_come_check

    # @product_in_out.stop_user_id = session[:user_id]
    # @product_in_out.stoped_at = DateTime.now
    @product_in_out.in_come_check = "Y"
    @product_in_out.save

    redirect_to :action=>'out_list'

  end

  def in_come_destroy

    @product_in_out.stop_user_id = session[:user_id]
    @product_in_out.stoped_at = DateTime.now
    @product_in_out.state = "N"
    @product_in_out.save

    redirect_to :action=>'in_list'

  end

  def out_come_destroy

    @product_in_out.stop_user_id = session[:user_id]
    @product_in_out.stoped_at = DateTime.now
    @product_in_out.state = "N"
    @product_in_out.save
    redirect_to :action=>'out_list'

  end

  private

    def sort_column
      ProductInOut.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def today_in_out_count
      in_out_cs = ProductInOut.where(
            'created_at >= :start_days_ago or created_at >= :end_days_ago',
                :start_days_ago   => Time.now.strftime("%Y-%m-%d 00:00:01"),
                :end_days_ago     => Time.now.strftime("%Y-%m-%d 23:23:59")
      )

      @io_s = ''
      @io_s.to_s

      (5 - in_out_cs.count.to_s.length.to_i).times do |aa|
        @io_s += "0"
      end

      @io_s += (in_out_cs.count.to_i + 1).to_s

      return @io_s

    end

    def set_title
      @title  = ['main1'=>'庫存首頁', 'main2'=>'product_in_outs','sub1'=>'庫存' , 'sub2'=>'product_in_outs' ]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_product_in_out
      @product_in_out = ProductInOut.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_in_out_params
      params.require(:product_in_out).permit( :product_id, :code, :num, :in_or_out,
                                              :create_user_id, :modify_user_id, :stop_user_id,
                                              :serial , :store_area_id , :level ,:save_date,
                                              :stoped_at , :state , :in_out_type_id)
    end

    def set_in_out_type

      @levels = [ 'good'=>'良品' , 'bad'=>'不良' ]
      @in_out_types = [ 'value'=>['in'=>'加','out'=>'減'] ]

    end
end
