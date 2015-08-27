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

            if pio.in_or_out == 'add' && pio.in_come_check == 'Y'
              add += pio.num
            end

            if pio.in_or_out == 'reduce' && pio.in_come_check == 'Y'
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


  def get_pro_in_outs_code(head)

    code_serial = ProductInOut.where('created_at >= :start_days_ago or created_at >= :end_days_ago',
                                          :start_days_ago  => Time.now.strftime("%Y-%m-%d 00:00:01"),
                                          :end_days_ago => Time.now.strftime("%Y-%m-%d 23:23:59"))

    len_s = self.order_serial_code(code_serial.count.to_s.length)
    len_s = "#{len_s}#{code_serial.count.to_i+1}"
    cstring = Time.now.strftime("%Y%m%d")

    return hide_code = "#{head}-#{cstring}-#{len_s}"

  end

  def product_out obj

        code_serial = ProductInOut.where('created_at >= :start_days_ago or created_at >= :end_days_ago',
                                              :start_days_ago  => Time.now.strftime("%Y-%m-%d 00:00:01"),
                                              :end_days_ago => Time.now.strftime("%Y-%m-%d 23:23:59"))

        len_s = self.order_serial_code(code_serial.count.to_s.length)
        len_s = "#{len_s}#{code_serial.count.to_i+1}"
        cstring = Time.now.strftime("%Y%m%d")
        hide_code = "OUT-#{cstring}-#{len_s}"

        pios = ProductInOut.where(:product_id => obj.product_id ,:in_come_check =>'Y' )

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



        pio_final_num = pio_add_num - pio_reduce_num
        # logger.fatal  "庫存#{pio_final_num} 等於= （進貨）#{pio_add_num} 減去- （出庫）#{pio_reduce_num}"

        pioFirst = ProductInOut.where(:product_id => obj.product_id,:is_finish => 'N', :in_or_out =>'add')
                               .group(:level)
                               .group(:store_area_id)
                               .group(:serial)
                               .group(:save_date)
                               .order("save_date ASC")
                               .first



        # logger.fatal  "2.pioFirst.id = #{pioFirst.id} / num = #{pioFirst.id} \nobj.num.to_i = #{obj.num.to_i}"
        #庫存數    大於  訂單數
        strHead     =   "OUT"
        sHead       =   get_pro_in_outs_code(strHead)

        #訂單數          小於     庫存數
        if obj.num.to_i < pio_final_num.to_i

                #訂單數  大於  單筆庫存的筆數
                if  obj.num.to_i > pioFirst.num.to_i
                    # logger.fatal  "3.-1"
                    remain_num  =   obj.num.to_i - pioFirst.num.to_i


                    firstPIO = ProductInOut.create( :product_id => obj.product_id.to_i ,
                                         :code => sHead ,
                                         :create_user_id => session[:user_id].to_i,
                                         :serial  =>  pioFirst.serial ,
                                         :state   =>  'Y' ,
                                         :wait_order_id  =>  obj.id,
                                         :num  =>  pioFirst.num.to_i ,
                                         :in_or_out  =>  'reduce',
                                         :in_out_type_id => 2 ,
                                         :store_area_id => pioFirst.store_area_id,
                                         :level =>pioFirst.level,
                                         :in_come_check =>'Y',
                                         :save_date =>pioFirst.save_date )

                    firstPIO.in_come_check ='Y'
                    firstPIO.save

                    pioFirst.is_finish = 'Y'
                    pioFirst.save
                    self.remain_reduce(remain_num , pioFirst.product_id , obj )


                elsif obj.num.to_i < pioFirst.num.to_i
                    # 當單筆的庫存數  大於  訂單數
                    # logger.fatal  "4."
                    firstPIO = ProductInOut.create( :product_id => obj.product_id.to_i ,
                                         :code => sHead ,
                                         :create_user_id => session[:user_id].to_i,
                                         :serial  =>  pioFirst.serial ,
                                         :state   =>  'Y' ,
                                         :wait_order_id  =>  obj.id,
                                         :num  =>  obj.num.to_i,
                                         :in_or_out  =>  'reduce',
                                         :in_out_type_id => 2 ,
                                         :store_area_id => pioFirst.store_area_id,
                                         :level =>pioFirst.level,
                                         :in_come_check =>'Y',
                                         :save_date =>pioFirst.save_date )
                   firstPIO.in_come_check ='Y'
                   firstPIO.save
                elsif obj.num.to_i == pioFirst.num.to_i

                    firstPIO = ProductInOut.create( :product_id => obj.product_id.to_i ,
                                         :code => sHead ,
                                         :create_user_id => session[:user_id].to_i,
                                         :serial  =>  pioFirst.serial ,
                                         :state   =>  'Y' ,
                                         :wait_order_id  =>  obj.id,
                                         :num  =>  pioFirst.num.to_i ,
                                         :in_or_out  =>  'reduce',
                                         :in_out_type_id => 2 ,
                                         :store_area_id => pioFirst.store_area_id,
                                         :level =>pioFirst.level,
                                         :in_come_check =>'Y',
                                         :save_date =>pioFirst.save_date)
                    firstPIO.in_come_check ='Y'
                    firstPIO.save
                    pioFirst.is_finish = 'Y'
                    pioFirst.save

                end

        elsif pio_final_num.to_i == obj.num.to_i

          firstPIO = ProductInOut.create( :product_id => obj.product_id.to_i ,
                               :code => sHead ,
                               :create_user_id => session[:user_id].to_i,
                               :serial  =>  pioFirst.serial ,
                               :state   =>  'Y' ,
                               :wait_order_id  =>  obj.id,
                               :num  =>  obj.num.to_i ,
                               :in_or_out  =>  'reduce',
                               :in_out_type_id => 2 ,
                               :store_area_id => pioFirst.store_area_id,
                               :level =>pioFirst.level,
                               :in_come_check =>'Y',
                               :save_date =>pioFirst.save_date)

         #出庫完成 入庫結束

         firstPIO.in_come_check ='Y'
         firstPIO.save

         pioFirst.is_finish = 'Y'
         pioFirst.save
              # logger.fatal  "3.-#{pioFirst.id}/#{pioFirst.num}"
              # logger.fatal  "pio_final_num.to_i = #{pio_final_num.to_i}  ======  obj.num.to_i = #{obj.num.to_i}"

        end

        return obj
  end


  #                 剩下的數量  ，產品ID
  def remain_reduce(remain_num , product_id ,obj)

      logger.info "remain_reduce(remain_num , product_id ,obj)"
      logger.info "#{remain_num.to_i} - #{product_id} - #{obj}"

      remain_num2 = 0

      pio_one = ProductInOut.where(:product_id => product_id )
                            .where(:is_finish => 'N')
                            .where(:in_or_out => 'add')
                            .group(:level)
                            .group(:store_area_id)
                            .group(:serial)
                            .group(:save_date)
                            .order("save_date ASC")
                            .first

      # logger.fatal "\nRemain num =  #{remain_num.to_i}"
      # logger.fatal "\npio_one[object] =  #{pio_one.id}"

      remain_num2 = remain_num.to_i - pio_one.num.to_i

      strHead =  "OUT"

      sHead   =  get_pro_in_outs_code(strHead)

      if  remain_num.to_i > pio_one.num.to_i

          logger.info "if  remain_num.to_i > pio_one.num.to_i"
          logger.info "#{remain_num.to_i}-#{pio_one.num.to_i}"

          # firstPIO.in_come_check ='Y'
          firstPIO = ProductInOut.create( :product_id => product_id.to_i ,
                               :code => sHead ,
                               :create_user_id => session[:user_id].to_i,
                               :serial  =>  pio_one.serial ,
                               :state   =>  'Y' ,
                               :wait_order_id  =>  obj.id,
                               :num  =>  pio_one.num.to_i ,
                               :in_or_out  =>  'reduce',
                               :in_out_type_id => 2 ,
                               :store_area_id => pio_one.store_area_id,
                               :level =>pio_one.level,
                               :in_come_check =>'Y',
                               :save_date =>pio_one.save_date )


          firstPIO.in_come_check ='Y'
          firstPIO.save

          pio_one.is_finish = 'Y'
          pio_one.save

          self.remain_reduce(remain_num2.to_i , product_id , obj )

      elsif  remain_num.to_i <= pio_one.num.to_i

        logger.info "elsif  remain_num.to_i < pio_one.num.to_i"
        logger.info " #{remain_num.to_i} - #{pio_one.num.to_i}"


        firstPIO = ProductInOut.create( :product_id => product_id.to_i ,
                             :code => sHead,
                             :create_user_id => session[:user_id].to_i,
                             :serial  =>  pio_one.serial ,
                             :state   =>  'Y' ,
                             :num  =>  remain_num.to_i ,
                             :in_or_out  =>  'reduce',
                             :wait_order_id  =>  obj.id,
                             :in_out_type_id => 2 ,
                             :store_area_id => pio_one.store_area_id,
                             :level =>pio_one.level,
                             :in_come_check =>'Y',
                             :save_date =>pio_one.save_date )

         firstPIO.in_come_check ='Y'
         firstPIO.save

      end

  end




end
