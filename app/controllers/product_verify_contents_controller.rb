class ProductVerifyContentsController < ApplicationController
  layout 'admin'

  before_action :set_title
  #要登入
  before_action :confirm_logged_in
  #取得一些基本資訊
  before_action :get_base_data



  before_action :set_product_verify_content, only: [:show, :edit, :update, :destroy]
  
  helper_method :sort_column, :sort_direction
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
    @product_verify_id = params[:id]
  end

  # POST /product_verify_contents
  # POST /product_verify_contents.json
  def create
    @product_verify_content = ProductVerifyContent.new(product_verify_content_params)


      if @product_verify_content.save


        uploaded_io = params[:product_verify_content][:file]

        # File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
        #   file.write(uploaded_io.read)
        # end

        if uploaded_io
            img_name = Time.now.strftime("%Y%d%m%H%M%S").to_s

            File.open(Rails.root.join('public', 'uploads', img_name ), 'wb') do |file|
              file.write(uploaded_io.read)
            end



            @product_verify_content.file ='/uploads/' + img_name.to_s
            @product_verify_content.save

        end
        pvi = params[:pv_id]


        flash[:notice] = '回復成功'
        redirect_to  :controller=>'product_verifies' ,:action=>'edit' , :id =>pvi.to_i


      else

        format.html { render action: 'new' }
        format.json { render json: @product_verify_content.errors, status: :unprocessable_entity }

      end
    # end
  end

  # PATCH/PUT /product_verify_contents/1
  # PATCH/PUT /product_verify_contents/1.json
  def update
      # render :text=>params
      if @product_verify_content.update(product_verify_content_params)

        uploaded_io = params[:product_verify_content][:file]

        # File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
        #   file.write(uploaded_io.read)
        # end

        if uploaded_io

            img_name = Time.now.strftime("%Y%d%m%H%M%S").to_s
            File.open(Rails.root.join('public', 'uploads', img_name ), 'wb') do |file|
              file.write(uploaded_io.read)
            end



            @product_verify_content.file ='/uploads/' + img_name.to_s
            @product_verify_content.save

        end

        @product_verify_content.state = 'Y'
        @product_verify_content.save
        pvi = params[:pv_id]


        flash[:notice] = '回復成功'
        redirect_to  :controller=>'product_verifies' ,:action=>'edit' , :id =>pvi.to_i


        # flash[:notice] = '回復成功'
        # redirect_to :controller=>'product_verifies'  ,:action=>'edit' ,:id =>@product_verify_content.product_verify_id
      else
        render action: 'edit'
      end

  end

  # DELETE /product_verify_contents/1
  # DELETE /product_verify_contents/1.json
  def destroy
    # @product_verify_content.destroy

    @product_verify_content.stoped_at = DateTime.now
    @product_verify_content.stop_user_id = session[:user_id]
    @product_verify_content.state='N'
    @product_verify_content.save
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
      params.require(:product_verify_content).permit(:content, :product_verify_id   , :title ,:create_user_id, :modify_user_id, :stoped_user_id, :stoped_at , :state)

    end
end
