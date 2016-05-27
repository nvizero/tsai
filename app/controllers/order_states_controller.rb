class OrderStatesController < ApplicationController
  before_action :set_order_state, only: [:show, :edit, :update, :destroy]

  before_action :set_title

  layout "admin"
  #取得一些基本資訊
  before_action :get_base_data
  #要登入
  before_action :confirm_logged_in

  helper_method :sort_column, :sort_direction


  # GET /order_states
  # GET /order_states.json
  def index

    # OrderState.all.each do |ost|
    #   ost.state = 'Y'
    #   ost.save
    # end

    @users_a = self.user_to_ar
    @flag = params[:state]
    if @flag=="Y"

      @order_states = OrderState.live.order(sort_column + " " + sort_direction).page params[:page]

    elsif @flag=="N"

      @order_states = OrderState.stoped.order(sort_column + " " + sort_direction).page params[:page]

    else

      @flag="Y"
      @order_states = OrderState.live.order(sort_column + " " + sort_direction).page params[:page]

    end
  end

  # GET /order_states/1
  # GET /order_states/1.json
  def show
  end

  # GET /order_states/new
  def new
    @order_state = OrderState.new
  end

  # GET /order_states/1/edit
  def edit
  end

  # POST /order_states
  # POST /order_states.json
  def create
    @order_state = OrderState.new(order_state_params)

    respond_to do |format|
      if @order_state.save

        @order_state.create_user_id = session[:user_id]
        @order_state.save

        format.html {
          redirect_to :controller =>'order_states' ,:action=>'index'
          flash[:notice] ='訂單狀態新增成功!'
        }
        format.json { render action: 'show', status: :created, location: @order_state }
      else
        format.html { render action: 'new' }
        format.json { render json: @order_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_states/1
  # PATCH/PUT /order_states/1.json
  def update
    respond_to do |format|
      if @order_state.update(order_state_params)

        @order_state.modify_user_id = session[:user_id]
        @order_state.save

        format.html {
          redirect_to :controller =>"order_states" , :action =>'index'
          flash[:notice] =  '訂單狀態修改成功'

        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_states/1
  # DELETE /order_states/1.json
  def destroy

    @order_state.stoped_at = DateTime.now
    @order_state.stop_user_id = session[:user_id]
    @order_state.state='N'
    @order_state.save

    respond_to do |format|
      format.html { redirect_to order_states_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def sort_column
      OrderState.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_title
      @title = ['main1'=>'訂單狀態', 'main2'=>'order_states','sub1'=>'訂單狀態' , 'sub2'=>'order_states']
    end

    def set_order_state
      @order_state = OrderState.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_state_params
      params.require(:order_state).permit(:title, :state)
    end
end
