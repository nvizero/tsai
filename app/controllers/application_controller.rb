class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  Time.zone = "Taipei"

  def get_self_url
     request.original_url.split('/')
  end


  def user_to_ar
     users = User.all

     urs = []
     users.each do |ur|
       urs[ur.id] = ur.name
     end

     return urs

  end

  #權限判斷
  def jadge_access jadge_str

    if session[:user["access"]] == 'all'
      # render :text => "#{self.get_self_url[3]} -- GG"
    else

      # if jadge_str in session[:user["access"]]
        jadge_flag = false

        @a_str = ''
        session[:user["access"]].split(',').each do |ac|
          if ac == jadge_str
            jadge_flag = true
          end
        end

        if jadge_flag == false
          flash[:notice] = "您的權限不足!!"
          redirect_to(:controller => 'dashboard', :action => 'main')
          return false # halts the before_action
        end

    end

  end

  def confirm_logged_in

      unless session[:user_id]
        flash[:notice] = "會員專區請先登入!"
        redirect_to(:controller => 'login', :action => 'login_form')
        return false # halts the before_action
      else
        return true
      end

  end

  def get_base_data
    @head_msgs = Msg.top.live
    @mid_msgs = Msg.mid.live
  end


  #vip or admin or normal
  def user_vip_access

      cdi = []
      if session[:vip_access] =='VIP'
        UserBelong.where(:belong_user_id =>session[:user_id] ).each do |ubi|
            if !ubi.id.nil?
                cdi[cdi.count] = ubi.user_id
            end
        end

        cdi[cdi.count] = session[:user_id]

      elsif session[:vip_access] =='admin'

        cdi = []

      elsif session[:vip_access] =='normal'

        cdi[cdi.count] = session[:user_id]
      end



      return cdi
  end




  def get_random_str num

        o = [('a'..'z'), ('1'..'9'),('A'..'Z') ].map { |i| i.to_a }.flatten
        cg = (0...num).map { o[rand(o.length)] }.join

        return cg
  end

  #算庫存
  def product_stock obj
        # serial
        pios = ProductInOut.where(:product_id => obj.product_id)

        add = 0
        reduce = 0
        pios.each do |pio|

            if pio.in_or_out == 'add'
              add += pio.num
            end

            if pio.in_or_out == 'reduce'
              reduce += pio.num
            end

        end

        final = add - reduce

        return add , reduce , final
  end


  def order_serial_code str_len
    ct = 5-str_len.to_i
    cstr = ''
    ct.times do |ee|
      cstr+='0'
    end
    return cstr
  end


  def product_out obj

        code_serial = ProductInOut.where('created_at >= :start_days_ago or created_at >= :end_days_ago',
                                              :start_days_ago  => Time.now.strftime("%Y-%m-%d 00:00:01"),
                                              :end_days_ago => Time.now.strftime("%Y-%m-%d 23:23:59"))

        len_s = self.order_serial_code(code_serial.count.to_s.length)
        len_s = "#{len_s}#{code_serial.count.to_i+1}"
        cstring = Time.now.strftime("%Y%m%d")
        hide_code = "OUT-#{cstring}-#{len_s}"

        pios = ProductInOut.where(:product_id => obj.product_id)

        pio_final_num   = 0
        pio_add_num     = 0
        pio_reduce_num  = 0

        pios.each do |pio|

            if  pio.in_or_out=='add'
                  pio_add_num += pio.num
            end

            if  pio.in_or_out=='reduce'
                  pio_reduce_num += pio.num
            end

        end


        # logger.info  "#{obj.product_id}_other_pioother_pioother_pioother_pioother_pioother_pioother_pioother_pioother_pioother_pioother_pioother_pioother_pio"
        pio_final_num = pio_add_num - pio_reduce_num


        pioFirst = ProductInOut.where(:product_id => obj.product_id,:is_finish => 'N', :in_or_out =>'add')
                               .order("save_date ASC")
                               .first


        logger.fatal " id = #{pioFirst.id}  code = #{pioFirst.code}  serial = #{pioFirst.serial}"
        logger.fatal " num = #{pioFirst.num}\nnow obj num = #{obj.num}       "
        logger.fatal " ----------------------------------------------------- "
        logger.fatal " #{pio_final_num} = #{pio_add_num} - #{pio_reduce_num} "
        logger.fatal " ===================================================== "
        logger.fatal " obj.num = #{obj.num} "
        logger.fatal " %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% "

        if pio_final_num.to_i >= obj.num.to_i
            #訂單數  大於  單筆的筆數
            if  obj.num.to_i > pioFirst.num.to_i

                remain_num = obj.num.to_i - pioFirst.num.to_i

                ProductInOut.create( :product_id => obj.product_id.to_i ,
                                     :code => pioFirst.code,
                                     :create_user_id => session[:user_id].to_i,
                                     :serial  =>  pioFirst.serial ,
                                     :state   =>  'Y' ,
                                    #  :num  =>  obj.num.to_i  ,
                                     :num  =>  pioFirst.num.to_i ,
                                     :in_or_out  =>  'reduce',
                                     :in_out_type_id => 2 ,
                                     :store_area_id => pioFirst.store_area_id,
                                     :level =>pioFirst.level,
                                     :save_date =>pioFirst.save_date )

                pioFirst.is_finish = 'Y'
                pioFirst.save
                
                self.remain_reduce(remain_num , pioFirst.product_id )

            end

            wo = WaitOrder.find(obj.id)
            wo.product_in_outs_code = pioFirst.serial
            wo.save
            # logger.info  "-sandy-|-sandy-|-sandy-|-sandy-|-sandy-"
        end

        return obj
  end


  #                 剩下的數量  ，產品ID
  def remain_reduce(remain_num , product_id )

      remain_num2 = 0

      pio_one = ProductInOut.where(:product_id => product_id )
                            .where(:is_finish => 'N')
                            .where(:in_or_out => 'add')
                            .order("save_date ASC")
                            .first

      logger.fatal "\nRemain num =  #{remain_num.to_i}"
      logger.fatal "\npio_one[object] =  #{pio_one.id}"

      remain_num2 = remain_num.to_i - pio_one.num.to_i

      if  remain_num.to_i > pio_one.num.to_i

          logger.fatal "\nin side pio_one [object] =  #{pio_one.id} "

          ProductInOut.create( :product_id => product_id.to_i ,
                               :code => pio_one.code,
                               :create_user_id => session[:user_id].to_i,
                               :serial  =>  pio_one.serial ,
                               :state   =>  'Y' ,
                               :num  =>  pio_one.num.to_i ,
                               :in_or_out  =>  'reduce',
                               :in_out_type_id => 2 ,
                               :store_area_id => pio_one.store_area_id,
                               :level =>pio_one.level,
                               :save_date =>pio_one.save_date )



          pio_one.is_finish = 'Y'
          pio_one.save
          self.remain_reduce(remain_num2.to_i , product_id )

      else


        ProductInOut.create( :product_id => product_id.to_i ,
                             :code => pio_one.code,
                             :create_user_id => session[:user_id].to_i,
                             :serial  =>  pio_one.serial ,
                             :state   =>  'Y' ,
                             :num  =>  remain_num.to_i ,
                             :in_or_out  =>  'reduce',
                             :in_out_type_id => 2 ,
                             :store_area_id => pio_one.store_area_id,
                             :level =>pio_one.level,
                             :save_date =>pio_one.save_date )

      end

  end




end
