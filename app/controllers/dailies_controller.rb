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

    # Daily.all.each do |dai|
    #     dai.state = 'Y'
    #     dai.save
    # end

    @flag = params[:state]
    if @flag=='N'
        @dailies = Daily.stoped.page params[:page]
    else
        @dailies = Daily.live.page params[:page]
        @flag='Y'
    end

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

      daily = params[:daily]
      daily_a = daily.to_a
      good_day_to_die = "#{daily_a[0][1]}-#{daily_a[1][1]}-#{daily_a[2][1]}"

      # render :text => "#{good_day_to_die} #{daily[:day_type]}"
      find_day = Daily.where(:day_type => daily[:day_type] , :day => good_day_to_die).first

      if !find_day.nil?
            #有找到一樣的～不可以再輸入一次
            # render :text => "yes day !!->>>#{find_day.id} "
            flash[:notice] = "日報-有重複的日期!!"
            @time_type = ['早上','下午']
            @daily = Daily.new
            render action: 'new'
      else

            #沒有找到一樣的～可以就新增!!
            if @daily.save

              flash[:notice] = "日報-新增成功!"
              redirect_to :action=> :index
              # format.html { redirect_to @daily, notice: 'Daily was successfully created.' }
              # format.json { render action: 'show', status: :created, location: @daily }
            else
              @time_type = ['早上','下午']
              @daily = Daily.new
              render action: 'new'
              # format.html { render action: 'new' }
              # format.json { render json: @daily.errors, status: :unprocessable_entity }
            end

      end
      # if @daily.save
      #   flash[:notice] = "日報-新增成功!"
      #   redirect_to :action=> :index
      #   # format.html { redirect_to @daily, notice: 'Daily was successfully created.' }
      #   # format.json { render action: 'show', status: :created, location: @daily }
      # else
      #   format.html { render action: 'new' }
      #   format.json { render json: @daily.errors, status: :unprocessable_entity }
      # end

  end

  # PATCH/PUT /dailies/1
  # PATCH/PUT /dailies/1.json
  def update
    # respond_to do |format|
    # daily = params[:daily]
    # daily_a = daily.to_a
    # good_day_to_die = "#{daily_a[0][1]}-#{daily_a[1][1]}-#{daily_a[2][1]}"
    #
    # # render :text => "#{good_day_to_die} #{daily[:day_type]}"
    # find_day = Daily.where(:day_type => daily[:day_type] , :day => good_day_to_die).first
    #
    # if !find_day.nil?
    #       #有找到一樣的～不可以再輸入一次
    #       # render :text => "yes day !!->>>#{find_day.id} "
    #       flash[:notice] = "日報-有重複的日期!!"
    #       @time_type = ['早上','下午']
    #       @daily = Daily.new
    #       render action: 'edit'
    # else
          if @daily.update(daily_params)
            flash[:notice] = "日報-更新成功!!"
            redirect_to action: 'index'
            # format.html { redirect_to @daily, notice: 'Daily was successfully updated.' }
            # format.json { head :no_content }
          else
            # format.html { render action: 'edit' }
            # format.json { render json: @daily.errors, status: :unprocessable_entity }
            render action: 'edit'
          end
    # end
  end

  # DELETE /dailies/1
  # DELETE /dailies/1.json
  def destroy

    @daily.state = 'N'
    @daily.save

    # @daily.destroy

    respond_to do |format|
      format.html { redirect_to dailies_url }
      format.json { head :no_content }
    end
  end


  def daily_18

      @title  = ['main1'=>'排班/日報', 'main2'=>'Daily','sub1'=>'日報' , 'sub2'=>'Daily' ]
      @day0 = Date.today

      @all_days = Daily.all.to_a
      @day1 = Date.today.at_beginning_of_month.strftime
      @beginning＿on_week = Date.today.at_beginning_of_month.wday


      @day2 = Date.today.at_end_of_month.strftime
      @day＿week = Date.today.wday

      # render :layout => false
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
