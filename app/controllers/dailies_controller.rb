class DailiesController < ApplicationController
  layout 'admin'
  # layout nil
  # layout 'application', :except => :daily_18
  before_action :set_daily, only: [:show, :edit, :update, :destroy]
  before_action :set_title

  #要登入
  before_action :confirm_logged_in
  #取得一些基本資訊
  before_action :get_base_data

  helper_method :sort_column, :sort_direction


  def set_title
    @title  = ['main1'=>'日報', 'main2'=>'Daily','sub1'=>'日報' , 'sub2'=>'Daily' ]
  end



  # GET /dailies
  # GET /dailies.json
  def index
    @dailies = Daily.all
  end

  # GET /dailies/1
  # GET /dailies/1.json
  def show
  end

  # GET /dailies/new
  def new
    @time_type = ['早上','下午']
    @daily = Daily.new
  end

  # GET /dailies/1/edit
  def edit
    @time_type = ['早上','下午']
  end

  # POST /dailies
  # POST /dailies.json
  def create
    @daily = Daily.new(daily_params)

    # respond_to do |format|
      if @daily.save

        flash[:notice] = "日報-新增成功!"
        redirect_to :action=> :index

        # format.html { redirect_to @daily, notice: 'Daily was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @daily }
      else
        format.html { render action: 'new' }
        format.json { render json: @daily.errors, status: :unprocessable_entity }
      end
    # end
  end

  # PATCH/PUT /dailies/1
  # PATCH/PUT /dailies/1.json
  def update
    respond_to do |format|
      if @daily.update(daily_params)
        format.html { redirect_to @daily, notice: 'Daily was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @daily.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dailies/1
  # DELETE /dailies/1.json
  def destroy
    @daily.destroy
    respond_to do |format|
      format.html { redirect_to dailies_url }
      format.json { head :no_content }
    end
  end


  def daily_18
      @day0 = Date.today

      @day1 = Date.today.at_beginning_of_month.strftime
      @beginning＿on_week = Date.today.at_beginning_of_month.wday


      @day2 = Date.today.at_end_of_month.strftime
      @day＿week = Date.today.wday

      render :layout => false
      # layout nil
      # render 'daily_18'

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily
      @daily = Daily.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_params
      params.require(:daily).permit(:day, :day_type, :title, :content, :created_user_id, :modify_user_id, :stoped_at, :stop_user_id)
    end
end