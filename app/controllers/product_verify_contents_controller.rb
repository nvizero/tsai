class ProductVerifyContentsController < ApplicationController
  layout 'admin'

  before_action :set_title
  #要登入
  before_action :confirm_logged_in
  #取得一些基本資訊
  before_action :get_base_data



  before_action :set_product_verify_content, only: [:show, :edit, :update, :destroy]

  # GET /product_verify_contents
  # GET /product_verify_contents.json
  def index
    @product_verify_contents = ProductVerifyContent.all
  end

  # GET /product_verify_contents/1
  # GET /product_verify_contents/1.json
  def show
  end

  # GET /product_verify_contents/new
  def new
    @product_verify_id = params[:id]
    @product_verify_content = ProductVerifyContent.new
  end

  # GET /product_verify_contents/1/edit
  def edit
  end

  # POST /product_verify_contents
  # POST /product_verify_contents.json
  def create
    @product_verify_content = ProductVerifyContent.new(product_verify_content_params)


      if @product_verify_content.save

        flash[:notice] = '回復成功'
        redirect_to :controller=>'product_verifies' ,:action=>'edit' , :id =>@product_verify_content.product_verify_id

        # format.html { redirect_to @product_verify_content, notice: 'Product verify content was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @product_verify_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @product_verify_content.errors, status: :unprocessable_entity }
      end
    # end
  end

  # PATCH/PUT /product_verify_contents/1
  # PATCH/PUT /product_verify_contents/1.json
  def update

      # if @product_verify_content.update(product_verify_content_params)
      #
      #   # redirect_to @product_verify_content
      #
      #   redirect_to :controller=>'product_verifies' =>:action=>'edit' , :id => @product_verify_content.product_verify_id
      #
      # else
      #   render action: 'edit'
      #   # format.json { render json: @product_verify_content.errors, status: :unprocessable_entity }
      # end

  end

  # DELETE /product_verify_contents/1
  # DELETE /product_verify_contents/1.json
  def destroy
    @product_verify_content.destroy
    respond_to do |format|
      format.html { redirect_to product_verify_contents_url }
      format.json { head :no_content }
    end
  end

  private

    def set_title
      @title  = ['main1'=>'三證申請狀態', 'main2'=>'product_verify_state','sub1'=>'三證申請狀態' , 'sub2'=>'product_verify_state' ]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_product_verify_content
      @product_verify_content = ProductVerifyContent.find(params[:id] )
    end


    def product_verify_content_params
      params.require(:product_verify_content).permit(:content,:product_verify_id ,:file,:title ,:create_user_id, :modify_user_id, :stoped_user_id, :stoped_at , :state)

    end
end
