class ProductVerifiesController < ApplicationController
  before_action :set_product_verify, only: [:show, :edit, :update, :destroy]
  layout 'admin'


  #取得一些基本資訊
  before_action :get_base_data
  #設定上面的TITLT
  before_action :set_title





  #取得一些基本資訊
  before_action :get_base_data

  # GET /product_verifies
  # GET /product_verifies.json
  def index
    @product_verifies = ProductVerify.where(:product_id=>params[:id])
  end

  # GET /product_verifies/1
  # GET /product_verifies/1.json
  def show
  end

  # GET /product_verifies/new
  def new
    @product_id = params[:id]
    @product_verify = ProductVerify.new
  end


  def make
    p_v_types = ProductVerifyType.all
    product_id = params[:id]

    p_v_types.each do |type|

      ProductVerify.create( :product_id => product_id ,
                            :status => '0',
                            :product_verify_type_id=>type.id)
    end

    flash[:notice] = '申請三證成功!!'
    redirect_to :controller=>'products'

  end



  # GET /product_verifies/1/edit
  def edit
  end

  # POST /product_verifies
  # POST /product_verifies.json
  def create
    @product_verify = ProductVerify.new(product_verify_params)

    respond_to do |format|
      if @product_verify.save
        format.html { redirect_to @product_verify, notice: 'Product verify was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product_verify }
      else
        format.html { render action: 'new' }
        format.json { render json: @product_verify.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_verifies/1
  # PATCH/PUT /product_verifies/1.json
  def update
    respond_to do |format|
      if @product_verify.update(product_verify_params)
        format.html { redirect_to @product_verify, notice: 'Product verify was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product_verify.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_verifies/1
  # DELETE /product_verifies/1.json
  def destroy
    @product_verify.destroy
    respond_to do |format|
      format.html { redirect_to product_verifies_url }
      format.json { head :no_content }
    end
  end

  private
    def set_title
      @title = ['main1'=>'三證進度', 'main2'=>'product_verifies','sub1'=>'首頁' , 'sub2'=>'三證進度']
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_product_verify
      @product_verify = ProductVerify.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_verify_params
      params.require(:product_verify).permit(:product_id, :status, :product_verify_type_id)
    end
end
