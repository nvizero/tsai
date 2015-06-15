class ProductInOutsController < ApplicationController

  layout 'admin'

  before_action :set_product_in_out, only: [:show, :edit, :update, :destroy , :out_come_destroy , :in_come_destroy]

  before_action :set_title
  before_action :set_in_out_type
  #要登入
  before_action :confirm_logged_in
  #取得一些基本資訊
  before_action :get_base_data

  # GET /product_in_outs
  # GET /product_in_outs.json
  def index

    # ProductInOut.all.each do |pio|
    #   pio.state = 'Y'
    #   pio.save
    # end


    @users_a = self.user_to_ar
    @flag = params[:steta]
    @product_id = params[:product_id]
    if @product_id
      @product_data = Product.find(:id=>@product_id.to_i)
    end
    @product_in_outs = ProductInOut.page params[:page]

  end

  def in_list

    # ProductInOut.all.each do |pio|
    #   pio.state = 'Y'
    #   pio.save
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

    if @flag=='N'
        @product_in_outs = ProductInOut.in_come.stoped.page params[:page]

    elsif @flag=='Y'

        @product_in_outs = ProductInOut.in_come.live.page params[:page]

    else

        @product_in_outs = ProductInOut.in_come.live.page params[:page]
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
        @product_in_outs = ProductInOut.out_come.stoped.page params[:page]

    elsif @flag=='Y'

        @product_in_outs = ProductInOut.out_come.live.page params[:page]

    else

        @product_in_outs = ProductInOut.out_come.live.page params[:page]
        @flag='Y'
    end

  end
  # GET /product_in_outs/1
  # GET /product_in_outs/1.json
  def show
  end

  # GET /product_in_outs/new
  def new
    @product_id = params[:product_id]
    @product_data = Product.live
    @product_in_out = ProductInOut.new
  end

  # GET /product_in_outs/1/edit
  def edit

      @product_id = params[:product_id]

      if @product_id
        
        @product_data = Product.find(:id=>@product_id.to_i)
      else
        @product_data = Product.all
      end
  end

  # POST /product_in_outs
  # POST /product_in_outs.json
  def create

    @product_in_out = ProductInOut.new(product_in_out_params)

    # respond_to do |format|
      if @product_in_out.save
          flash[:notice] = "input success"
          redirect_to :controller=>'product_in_outs' , :action=>'index'


      else
        render action: 'new'

      end
    # end
  end

  # PATCH/PUT /product_in_outs/1
  # PATCH/PUT /product_in_outs/1.json
  def update
    respond_to do |format|
      if @product_in_out.update(product_in_out_params)
        format.html { redirect_to @product_in_out, notice: 'Product in out was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product_in_out.errors, status: :unprocessable_entity }
      end
    end
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
                                              :stoped_at , :state)
    end

    def set_in_out_type
      @in_out_types = ['in','out']
    end
end
