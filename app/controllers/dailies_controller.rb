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

  def del_19

    ProductInOut.all.each do |pp|
      pp.delete
    end

    OrderByProduct.all.each do |pp|
      pp.delete
    end

    ProductOrder.all.each do |pp|
      pp.delete
    end

    WaitOrder.all.each do |pp|
      pp.delete
    end
    #

    ProductInOut.create("product_id"=>"1", "serial"=>"11111",
                        "in_or_out"=>"add", "in_out_type_id"=>"1",
                        "store_area_id"=>"qw", "level"=>"good",
                        "save_date"=>"2015-09-02", "num"=>"100",
                        "code"=>"IN-20150919-00001", "create_user_id"=>"2",
                        "state"=>"Y" , "in_come_check"=>'Y' )

    ProductInOut.create("product_id"=>"1", "serial"=>"22222",
                        "in_or_out"=>"add", "in_out_type_id"=>"1",
                        "store_area_id"=>"qw", "level"=>"good",
                        "save_date"=>"2015-09-01", "num"=>"240",
                        "code"=>"IN-20150919-00004", "create_user_id"=>"2",
                        "state"=>"Y" , "in_come_check"=>'Y' )

    ProductInOut.create("product_id"=>"1", "serial"=>"33333",
                        "in_or_out"=>"add", "in_out_type_id"=>"1",
                        "store_area_id"=>"qw", "level"=>"good",
                        "save_date"=>"2015-09-28", "num"=>"220",
                        "code"=>"IN-20150919-00002", "create_user_id"=>"2",
                        "state"=>"Y" , "in_come_check"=>'Y' )

    ProductInOut.create("product_id"=>"1",
                        "serial"=>"44444",
                        "in_or_out"=>"add",
                        "in_out_type_id"=>"1",
                        "store_area_id"=>"qw", "level"=>"good",
                        "save_date"=>"2015-09-1", "num"=>"300",
                        "code"=>"IN-20150919-00003", "create_user_id"=>"2",
                        "state"=>"Y" , "in_come_check"=>'Y' )

    ProductInOut.create("product_id"=>"1",
                        "serial"=>"555",
                        "in_or_out"=>"add",
                        "in_out_type_id"=>"1",
                        "store_area_id"=>"qw", "level"=>"good",
                        "save_date"=>"2015-08-1", "num"=>"10",
                        "code"=>"IN-20150919-00004", "create_user_id"=>"2",
                        "state"=>"Y" , "in_come_check"=>'Y' )

    ProductInOut.create("product_id"=>"1",
                        "serial"=>"55aa",
                        "in_or_out"=>"add",
                        "in_out_type_id"=>"1",
                        "store_area_id"=>"qw", "level"=>"good",
                        "save_date"=>"2015-08-1", "num"=>"30",
                        "code"=>"IN-20150919-00005", "create_user_id"=>"2",
                        "state"=>"Y" , "in_come_check"=>'Y' )

    ProductOrder.create( "code" => 'ORDER-20150922-00001' ,
                         "order_state_id" => 1,
                         "member_id" => 1,
                         "state" => 'Y',
                         "create_user_id" => 2,
                         "modify_user_id" => 2,
                        "stop_user_id" => "NULL",
                        "stoped_at"  => "NULL",
                        "created_at" => '2015-09-22 06:09:34',
                        "updated_at" => '2015-09-22 06:09:34',
                        "order_day"  => '2015-09-22',
                        "total"      => 500,
                        "pay_type_id"=> 1,
                        "future_day" => '2015-09-22',
                        "confirm_order" => 'N')


    OrderByProduct.create("product_id"=>1,
                          "code"=>'ORDER-20150922-00001',
                          "num"=>500,
                          "create_user_id"=>2,
                          "modify_user_id"=>"NULL",
                          "stop_user_id"=>"NULL",
                          "stoped_at"=>"NULL",
                          "created_at"=>'2015-09-22 06:04:25',
                          "updated_at"=>'2015-09-22 06:04:25',
                          "price"=>1,
                          "total"=>500,
                          "product_code"=>"NULL")


    ProductOrder.create( "code" => 'ORDER-20150925-00001' ,
                         "order_state_id" => 1,
                         "member_id" => 1,
                         "state" => 'Y',
                         "create_user_id" => 2,
                         "modify_user_id" => 2,
                        "stop_user_id" => "NULL",
                        "stoped_at"  => "NULL",
                        "created_at" => '2015-09-22 06:09:34',
                        "updated_at" => '2015-09-22 06:09:34',
                        "order_day"  => '2015-09-22',
                        "total"      => 300,
                        "pay_type_id"=> 1,
                        "future_day" => '2015-09-22',
                        "confirm_order" => 'N')


    OrderByProduct.create("product_id"=>1,
                          "code"=>'ORDER-20150925-00001',
                          "num"=>300,
                          "create_user_id"=>2,
                          "modify_user_id"=>"NULL",
                          "stop_user_id"=>"NULL",
                          "stoped_at"=>"NULL",
                          "created_at"=>'2015-09-22 06:04:25',
                          "updated_at"=>'2015-09-22 06:04:25',
                          "price"=>1,
                          "total"=>300,
                          "product_code"=>"NULL")

    ProductOrder.create( "code" => 'ORDER-20150925-00002' ,
                         "order_state_id" => 1,
                         "member_id" => 1,
                         "state" => 'Y',
                         "create_user_id" => 2,
                         "modify_user_id" => 2,
                        "stop_user_id" => "NULL",
                        "stoped_at"  => "NULL",
                        "created_at" => '2015-09-22 06:09:34',
                        "updated_at" => '2015-09-22 06:09:34',
                        "order_day"  => '2015-09-22',
                        "total"      => 40,
                        "pay_type_id"=> 1,
                        "future_day" => '2015-09-22',
                        "confirm_order" => 'N')


    OrderByProduct.create("product_id"=>1,
                          "code"=>'ORDER-20150925-00002',
                          "num"=>40,
                          "create_user_id"=>2,
                          "modify_user_id"=>"NULL",
                          "stop_user_id"=>"NULL",
                          "stoped_at"=>"NULL",
                          "created_at"=>'2015-09-22 06:04:25',
                          "updated_at"=>'2015-09-22 06:04:25',
                          "price"=>1,
                          "total"=>40,
                          "product_code"=>"NULL")
    #
    #
    # render :text=>'sandy

    sandy = ''
    # Access.all.each do |ac|
    #   sandy+="#{ac.title}/#{ac.code}<br>"
    # end

    render :text=>"#{sandy}"
  end



  # GET /dailies
  # GET /dailies.json
  def index

    # Daily.all.each do |dai|
        # dai.state = 'Y'
        # dai.save
    #     dai.delete
    # end

    @flag = params[:state]
    if @flag=='N'
        @dailies = Daily.stoped.order('day desc').page params[:page]
    else
        @dailies = Daily.live.order('day desc').page params[:page]
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
            # 有找到一樣的～不可以再輸入一次
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

      @d_user1 = Daily.where("title like ?", "%俊德%")
      @d_user2 = Daily.where("title like ?", "%嘉俊%")
      @d_user3 = Daily.where("title like ?", "%為明%")

      @title  = ['main1'=>'排班/日報', 'main2'=>'Daily 18','sub1'=>'日報' , 'sub2'=>'Daily 18' ]

      @date = Time.now

      if !params[:month].nil?
        @_today = @date.strftime("%Y-"+params[:month]+"-%d")
      else
        @_today = @date.strftime("%Y-%m-%d")
      end


      @day0 = Date.today
      @params_moth = @day0.to_s.split('-')[1].to_i

      if (@params_moth == @_today.to_s.split('-')[1].to_i)

          @sandy_word = 'GG-if'
          @day_next = Date.today + 1.month
          @day_prev = Date.today.prev_month(1)
          @all_days = Daily.all.to_a
          @day1 = Date.today.at_beginning_of_month.strftime
          @beginning＿on_week = Date.today.at_beginning_of_month.wday
          @day2 = Date.today.at_end_of_month.strftime
          @day＿week = Date.today.wday
          @show_y_m = Date.today.strftime("%Y-%m")
          @date_month = Date.today.strftime("%m").to_i

      else


          @date = Time.now

          @d_p_m = @_today.split('-')[1].to_i
          @t_p_m = @date.strftime("%Y-%m-%d").split('-')[1].to_i

          @reduce_p_m = @t_p_m - @d_p_m
          @sandy_word = 'month -> '+@reduce_p_m.to_s

          @day_next = Date.today + (@reduce_p_m.to_i).month
          @day_prev = Date.today.prev_month(1)
          @all_days = Daily.all.to_a


          @r_day = Date.today.prev_month(@reduce_p_m.to_i)
          @show_y_m = Date.today.prev_month(@reduce_p_m.to_i).strftime("%Y-%m")
          @date_month = @r_day.strftime("%m").to_i
          @day1 = @r_day.at_beginning_of_month.strftime
          @beginning＿on_week = @r_day.at_beginning_of_month.wday
          @day2 = @r_day.at_end_of_month.strftime
          @day＿week = @r_day.wday

      end


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
