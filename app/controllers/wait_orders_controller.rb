class WaitOrdersController < ApplicationController
  before_action :set_wait_order, only: [:show, :edit, :update, :destroy]

  # GET /wait_orders
  # GET /wait_orders.json
  def index
    @wait_orders = WaitOrder.all
  end

  # GET /wait_orders/1
  # GET /wait_orders/1.json
  def show
  end

  # GET /wait_orders/new
  def new
    @wait_order = WaitOrder.new
  end

  # GET /wait_orders/1/edit
  def edit
  end

  # POST /wait_orders
  # POST /wait_orders.json
  def create
    @wait_order = WaitOrder.new(wait_order_params)

    respond_to do |format|
      if @wait_order.save
        format.html { redirect_to @wait_order, notice: 'Wait order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @wait_order }
      else
        format.html { render action: 'new' }
        format.json { render json: @wait_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wait_orders/1
  # PATCH/PUT /wait_orders/1.json
  def update
    respond_to do |format|
      if @wait_order.update(wait_order_params)
        format.html { redirect_to @wait_order, notice: 'Wait order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @wait_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wait_orders/1
  # DELETE /wait_orders/1.json
  def destroy
    @wait_order.destroy
    respond_to do |format|
      format.html { redirect_to wait_orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wait_order
      @wait_order = WaitOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wait_order_params
      params.require(:wait_order).permit(:product_id, :code, :num, :state, :create_user_id, :modify_user_id, :stop_user_id, :stoped_at, :serial, :save_date)
    end
end
