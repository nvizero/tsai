class PayTypesController < ApplicationController
  before_action :set_pay_type, only: [:show, :edit, :update, :destroy]


  before_action :set_title


  layout "admin"
  #取得一些基本資訊
  before_action :get_base_data
  #要登入
  before_action :confirm_logged_in

  helper_method :sort_column, :sort_direction


  # GET /pay_types
  # GET /pay_types.json
  def index

    PayType.all.each do |ptq|
        # ptq.state='Y'
        # ptq.save
    end

    @flag=params[:state]


    if params[:state]=='Y'
      @pay_types = PayType.live.order(sort_column + " " + sort_direction).page params[:page]
    elsif params[:state]=='N'
      @pay_types = PayType.stoped.order(sort_column + " " + sort_direction).page params[:page]
    else
      @flag='Y'
      @pay_types = PayType.live.order(sort_column + " " + sort_direction).page params[:page]
    end
  end

  # GET /pay_types/1
  # GET /pay_types/1.json
  def show
  end

  # GET /pay_types/new
  def new
    @pay_type = PayType.new
  end

  # GET /pay_types/1/edit
  def edit
  end

  # POST /pay_types
  # POST /pay_types.json
  def create
    @pay_type = PayType.new(pay_type_params)

    respond_to do |format|
      @pay_type.create_user_id = session[:user_id]

      if @pay_type.save
        format.html {
          flash[:notice] = '新增成功'
          redirect_to :controller =>'pay_types' , :action =>'index'
        }
        format.json { render action: 'show', status: :created, location: @pay_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @pay_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pay_types/1
  # PATCH/PUT /pay_types/1.json
  def update
    respond_to do |format|
      @pay_type.modify_user_id = session[:user_id]
      if @pay_type.update(pay_type_params)
        format.html {
          # redirect_to @pay_type, notice: 'Pay type was successfully updated.'
          flash[:notice] = '更新成功'
          redirect_to :controller =>'pay_types' , :action =>'index'
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pay_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pay_types/1
  # DELETE /pay_types/1.json
  def destroy
    # @pay_type.destroy

    @pay_type.stop_user_id = session[:user_id]
    @pay_type.stoped_at = DateTime.now
    @pay_type.state = "N"
    @pay_type.save


    respond_to do |format|
      format.html {
        redirect_to :controller =>'pay_types' , :action =>'index'
        # redirect_to pay_types_url
      }
      format.json { head :no_content }
    end
  end

  private

    def sort_column
      PayType.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_pay_type
      @pay_type = PayType.find(params[:id])
    end
    def set_title
      @title = ['main1'=>'付款方式', 'main2'=>'pay_types','sub1'=>'付款方式' , 'sub2'=>'pay_types']
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pay_type_params
      params.require(:pay_type).permit(:code, :content)
    end
end
