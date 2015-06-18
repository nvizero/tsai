class InOutTypesController < ApplicationController

  before_action :set_in_out_type, only: [:show, :edit, :update, :destroy]

  before_action :set_title

  before_action :base_data

  layout "admin"
  #取得一些基本資訊
  before_action :get_base_data
  #要登入
  before_action :confirm_logged_in


  # GET /in_out_types
  # GET /in_out_types.json
  def index

    # InOutType.all.each do |iot|
    #   iot.state = 'Y'
    #   iot.save
    # end

    @users_a = self.user_to_ar

    @flag = params[:state]

    if @flag=='Y'
      @in_out_types = InOutType.live.page params[:page]
    elsif @flag=='N'
      @in_out_types = InOutType.stoped.page params[:page]
    else
      @in_out_types = InOutType.live.page params[:page]
    end

  end

  # GET /in_out_types/1
  # GET /in_out_types/1.json
  def show
  end

  # GET /in_out_types/new
  def new
    @in_out_type = InOutType.new
  end

  # GET /in_out_types/1/edit
  def edit
  end

  # POST /in_out_types
  # POST /in_out_types.json
  def create
    # render :text => params
    @in_out_type = InOutType.new(in_out_type_params)


      if @in_out_type.save
          @in_out_type.save
          redirect_to :controller =>'in_out_types' ,:action=>'index'
      else
          render action: 'new'
      end

  end

  # PATCH/PUT /in_out_types/1
  # PATCH/PUT /in_out_types/1.json
  def update

    respond_to do |format|
      if @in_out_type.update(in_out_type_params)
        format.html {
            flash[:notice] = '出入庫類別.更新成功!'
            redirect_to :controller =>'in_out_types' ,:action=>'index'
            }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @in_out_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /in_out_types/1
  # DELETE /in_out_types/1.json
  def destroy
    # @in_out_type.destroy
    @in_out_type.state = 'N'
    @in_out_type.save

    respond_to do |format|
      format.html {
          redirect_to :controller => 'in_out_types' ,:action =>'index'
      }
      format.json { head :no_content }
    end
  end

  private
    def set_title
      @title = ['main1'=>'入出庫類別', 'main2'=>'in_out_types','sub1'=>'首頁' , 'sub2'=>'in_out_types']
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_in_out_type
      @in_out_type = InOutType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def in_out_type_params
        params.require(:in_out_type).permit(:title, :cate, :state, :create_user_id )
    end

    def base_data
      @in_out_types = [ 'value'=>['aadd'=>'加','ddesc'=>'減'] ]
    end
end
