class ProductVerifyStatesController < ApplicationController
  layout 'admin'

  before_action :set_title
  #要登入
  before_action :confirm_logged_in
  #取得一些基本資訊
  before_action :get_base_data

  before_action :set_product_verify_state, only: [:show, :edit, :update, :destroy]

  # GET /product_verify_states
  # GET /product_verify_states.json
  def index

    @users_a = self.user_to_ar
    @flag = params[:steta]
    @product_id = params[:product_id]

    if @flag=='Y'
        @product_verify_states = ProductVerifyState.live.page params[:page]
    else
        @product_verify_states = ProductVerifyState.stoped.page params[:page]
        @flag = 'N'
    end

  end

  # GET /product_verify_states/1
  # GET /product_verify_states/1.json
  def show
  end

  # GET /product_verify_states/new
  def new
    @product_verify_state = ProductVerifyState.new
  end

  # GET /product_verify_states/1/edit
  def edit
  end

  # POST /product_verify_states
  # POST /product_verify_states.json
  def create
    @product_verify_state = ProductVerifyState.new(product_verify_state_params)


      if @product_verify_state.save
        flash[:notict] = '新增成功'
        redirect_to :controller=>'product_verify_states' , :action=>'index'
      else
        render action: 'new'
      end

  end

  # PATCH/PUT /product_verify_states/1
  # PATCH/PUT /product_verify_states/1.json
  def update

      if @product_verify_state.update(product_verify_state_params)
        flash[:notice] = '編輯成功！'
        redirect_to :controller =>'product_verify_states' , :action =>'index'


      else

        render action: 'edit'

      end

  end

  # DELETE /product_verify_states/1
  # DELETE /product_verify_states/1.json
  def destroy
    # @product_verify_state.destroy
    @product_verify_state.state = 'N'
    @product_verify_state.save

    respond_to do |format|
      format.html { redirect_to product_verify_states_url }
      format.json { head :no_content }
    end
  end

  private

    def set_title
      @title  = ['main1'=>'三證申請狀態', 'main2'=>'product_verify_state','sub1'=>'三證申請狀態' , 'sub2'=>'product_verify_state' ]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product_verify_state
      @product_verify_state = ProductVerifyState.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_verify_state_params
      params.require(:product_verify_state).permit(:title, :create_user_id, :modify_user_id, :stoped_user_id, :stoped_at)
    end
end
