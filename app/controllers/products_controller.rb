class ProductsController < ApplicationController


  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :get_verify_type_main, only: [:new, :edit ,:create ,:update]
  before_action :set_title

  layout "admin"
  #取得一些基本資訊
  before_action :get_base_data
  #要登入
  before_action :confirm_logged_in

  # GET /products
  # GET /products.json

  def index

    ci = 1
    ['瑪雅咖啡','鬆餅三號','花花','草草','大苑子','CoCo','50嵐'].each do |key , val|

        # Product.create!(:title=>"#{key}-#{ci}",
        #                 :specification => "coffe2#{val}" ,
        #                 :user_id=>ci ,
        #                 :state=>'Y' ,
        #                 :verify_type_main_id =>1 ,
        #                 :create_user_id => ci.to_i,
        #                 :code=>"#{key}/#{ci}")

        # ci+=1
    end

    # Product.all.each do |pp|
    #     pp.state = 'Y'
    #     pp.save
    # end

    @vip_access = user_vip_access

    @flag    = params['state']

    if session[:vip_access]=='VIP'

        # render :text => session[:vip_access]
        if !params['state'].nil?

            if session[:user["access"]] =='all'
                if @flag=='Y'
                    @products = Product.vip_access(@vip_access , session).live.page params[:page]
                else

                    @products = Product.vip_access(@vip_access , session).stoped.page params[:page]
                end
            else
                if @flag=='Y'
                    @products = Product.vip_access(@vip_access , session).live.page params[:page]
                else
                    @products = Product.vip_access(@vip_access , session).stoped.page params[:page]
                end
            end

        else

            @flag = 'Y'
            if session[:user["access"]] =='all'
              # render :text => session[:vip_access]
              # //
              @products = Product.vip_access(@vip_access , session).live.page params[:page]
            else
              @products = Product.vip_access(@vip_access , session).live.page params[:page]
            end
        end

    else

        if !params['state'].nil?

            if session[:user["access"]] =='all'
                if @flag=='Y'
                    @products = Product.vip_access(@vip_access , session).live.page params[:page]
                else
                    @products = Product.vip_access(@vip_access , session).stoped.page params[:page]
                end
            else
                if @flag=='Y'
                    @products = Product.vip_access(@vip_access , session).live.where(:user_id => @vip_access).page params[:page]
                else
                    @products = Product.vip_access(@vip_access , session).stoped.where(:user_id => @vip_access).page params[:page]
                end
            end

        else

            @flag = 'Y'
            if session[:user["access"]] =='all'

                #render :text => 'GG1'
                @products = Product.vip_access(@vip_access , session).live.page params[:page]
            else

                @products = Product.vip_access(@vip_access , session).where(:user_id => @vip_access).live.page params[:page]
            end
        end

    end


    @users_a = self.user_to_ar


  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  def store_list

    @title[0]['main1']='商品庫存'

    if !params['state'].nil?

        @flag    = params['state']
        if session[:user["access"]] =='all'


            if @flag=='Y'
                @products = Product.vip_access(user_vip_access , session).live.page params[:page]
            else
                @products = Product.vip_access(user_vip_access , session).stoped.page params[:page]
            end

        else

            if @flag=='Y'
                @products = Product.vip_access(user_vip_access , session).live.page params[:page]
            else
                @products = Product.vip_access(user_vip_access , session).stoped.page params[:page]
            end

        end

    else

        @flag = 'Y'
        if session[:user["access"]] =='all'
          @products = Product.vip_access(user_vip_access , session).live.page params[:page]
        else
          @products = Product.vip_access(user_vip_access , session).live.page params[:page]
        end

    end

    @users_a = self.user_to_ar

  end

  # GET /products/new
  def new

    @title[0]['main1'] = "新增產品"
    @product = Product.new
    @store_areas = StoreArea.live


  end

  # GET /products/1/edit
  def edit
    @store_areas = StoreArea.live
  end

  # POST /products
  # POST /products.json
  def create

    @product = Product.new(product_params)
    @product.create_user_id = session[:user_id]

    if @product.save
        flash[:notice] = "產品-新增成功!"
        redirect_to action: "index"
    else
        @title[0]['main1'] = "新增產品"
        #@product = Product.new
        @store_areas = StoreArea.live
        render action: 'new'
    end

  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update

    @product.modify_user_id = session[:user_id]
    if @product.update(product_params)
      flash[:notice] = "產品-更新成功!"
      redirect_to action: "index"
    else
      @title[0]['main1'] = "產品編輯"
      @store_areas = StoreArea.live
      render action: 'edit'
    end

  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    # @product.destroy
    @product.state = 'N'
    @product.stop_user_id = session[:user_id]
    @product.stoped_at = DateTime.now
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
      params.require(:product).permit(:title, :content, :num, :user_id, :verify_type_main_id ,:code,:specification  ,:create_users_id ,
                                      :one_base , :one_heavy1, :one_heavy1_unit, :one_heavy2, :one_heavy2_unit,:modify_users_id,
                                      :size, :size1, :size2, :size3 ,:item_size, :item_size1, :item_size2, :item_size3, :unit_save,
                                      :unit_support, :ratio1, :ratio2 ,:create_users_id, :modify_users_id, :category, :form, :buy_batch,
                                      :affect_day, :head_date, :safe_save, :standard_store_area, :income_unit , :income_number, :stop_user_id , :stoped_at )

    end
end
