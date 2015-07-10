class PactController < ApplicationController


  skip_before_action :verify_authenticity_token

  def post_username
    user = User.where(:username=>params['username']).first
    if user
        if user.prompt.length > 1
          render :text => "您的密碼提示是:<font color=red>#{user.prompt}</font>"
        else
          render :text => "您的密碼提示是:<font color=red>沒有輸入</font>"
        end
    else
        render :text => '<font color="red">找不到帳號!請重輸入!</font>'
    end
  end


  def check_username
    user = User.where(:username=>params['username']).first
    if user
        render :text => 'y'
    else
        render :text => 'n'
    end
  end


  def check_email

    user = User.where(:email=>params['email']).first
    if user
        render :text => 'y'
    else
        render :text => 'n'
    end
  end



  def box
    render 'comm/_box'
  end


  def change_product_verify_state

    id =  params[:id]
    val =  params[:val]
    prv = ProductVerify.find(id)
    prv.product_verify_state_id = val.to_i
    prv.save

    pvs=ProductVerifyState.find(val.to_i)

    render :text => pvs.title
    # render :text => "#{params} + #{id} - #{prv}"
    # prv = ProductVerify.find(id)
    # prv.product_verify_state_id  = val.to_i
    # prv.save

  end

  def do_in_or_out
      iot = InOutType.find(params[:id])
      render :text => "#{iot.cate}"
  end

  def get_all_products

      pros_str='<select class="product_data" >'

      Product.live.each do |pro|
        pros_str+="<option value=#{pro.id}>#{pro.title}</option>"
      end

      pros_str+='</select>'
      render :text => pros_str

  end


  def post_order_data
    date_and_totalPrice = params[:date_and_totalPrice]
    member_id = params[:member_id]
    code = params[:code]
    all_str = params[:all_str]

    order_flag = false

    qq = ''
    total_price = 0


    all_str.split(',').each do |pr|

      product_data      =  pr.split('/')
      product_id        =  product_data[0]
      product_num       =  product_data[1]
      product_price     =  product_data[2]
      product_total     =  product_data[3]

      # logger.info  "--------#{product_data}------"

      if !product_id.nil? && !product_num.nil? && !product_price.nil? && !product_total.nil?
        order_flag = true

        total_price += product_total.to_i

        OrderByProduct.create(:product_id => product_id,
                              :num   => product_num,
                              :price => product_price,
                              :total => product_total,
                              :code  => code,
                              :create_user_id => session[:user_id] )
      end


    end



    if order_flag

      dataInfo = date_and_totalPrice.split('/')

      ProductOrder.create(  :order_state_id=>1,
                            :state=>'Y',
                            :member_id => member_id,
                            :code => code,
                            :total => dataInfo[1],
                            :future_day => dataInfo[0],
                            :pay_type_id => dataInfo[2],
                            :order_day => dataInfo[3],
                            :create_user_id => session[:user_id])
    end

    render :text => order_flag
    # render :text => params

  end


  def get_select_products

      pros_str='<select class="product_data" >'
      Product.where('id not in (?)',params[:pids].split('/') ).live.each do |pro|
        pros_str+="<option value=#{pro.id}>#{pro.title}</option>"
      end

      pros_str+='</select>'
      render :text => pros_str
  end


  def update_order_data

    date_and_totalPrice = params[:date_and_totalPrice]
    member_id = params[:member_id]
    code = params[:code]
    all_str = params[:all_str]

    logger.info "//#{params}//"


    order_flag = false

    qq = ''
    total_price = 0


    all_str.split(',').each do |pr|

      product_data      =  pr.split('/')
      product_id        =  product_data[0]
      product_num       =  product_data[1]
      product_price     =  product_data[2]
      product_total     =  product_data[3]

      logger.info  "--------#{product_data}------"

      if !product_id.nil? && !product_num.nil? && !product_price.nil? && !product_total.nil?

        order_flag = true

        total_price += product_total.to_i

        # "users.name = ? OR users.name = ?", request.requester, request.regional_sales_mgr)
        # orderPro = OrderByProduct.where(:product_id => product_id,:code  => code)
        # logger.info  "--------#{code} , #{product_id}------ "

        orderPro = OrderByProduct.where(:code =>code ,  :product_id => product_id).first

        if !orderPro.nil?

            orderPro.num   =  product_num
            orderPro.price =  product_price
            orderPro.total =  product_total
            orderPro.modify_user_id = session[:user_id]
            orderPro.save
        else
            OrderByProduct.create(:product_id => product_id,
                                  :num   => product_num,
                                  :price => product_price,
                                  :total => product_total,
                                  :code  => code,
                                  :create_user_id => session[:user_id] )
        end

        # OrderByProduct.create(:product_id => product_id,
        #                       :num   => product_num,
        #                       :price => product_price,
        #                       :total => product_total,
        #                       :code  => code,
        #                       :create_user_id => session[:user_id] )
      end


    end



    if order_flag

      dataInfo = date_and_totalPrice.split('/')
      proOrder = ProductOrder.find_by_code(code)



      proOrder.order_state_id = 1
      proOrder.member_id = member_id
      proOrder.code = code
      proOrder.total = dataInfo[1].to_i
      proOrder.future_day = dataInfo[0]
      proOrder.pay_type_id = dataInfo[2].to_i
      proOrder.order_day = dataInfo[3]
      proOrder.modify_user_id = session[:user_id]
      proOrder.save

    end

    render :text => order_flag

    # member_id = params[:member_id]
    # code = params[:code]
    #
    # # logger.info  " #{params} "
    # pr_od = ProductOrder.find_by_code(code)
    # pr_od.member_id = member_id
    # pr_od.save
    #
    # d_new     = params[:new]
    # d_update  = params[:update]
    # dduu = ''
    # #新增的
    # d_new.split('/').each do |new_one|
    #
    #   product_num   =  new_one.split(',')
    #   product_id    =  product_num[0].split('p_')
    #   OrderByProduct.create(:product_id => product_id[1],
    #                         :num => product_num[1],
    #                         :code=>code)
    # end
    #
    # #更新
    # d_update.split('/').each do |up_date|
    #
    #   pInfo   = up_date.split(',')
    #   dduu += "#{pInfo[0]}- #{pInfo[1]} "
    #
    #   # product_id    = product_num[0].split('p_')
    #   obp = OrderByProduct.find(pInfo[0].to_i)
    #   obp.num =pInfo[1].to_i
    #   obp.save
    #
    # end
    #
    # render :text => 'true'
  end




  def get_p_in_out_serial

    # pio_adds        = ProductInOut.where(:product_id => params[:id] , :in_or_out=>'add' )
    _id               = params[:id]
    pio_adds          = ProductInOut.where(:product_id => _id , :in_or_out => 'add' )
                                    .group(:serial , :level , :store_area_id , :save_date)
    pio_str           = '<option></option>'
    pio_adds.each do |pp|

      # logger.info  "/-/-/-/-/-/-/-/-/ ProductInOut #{pp.id} serial  #{pp.serial} "

      pio_add     = 0 # 加
      pio_reduce  = 0 # 減

      other_pio = ProductInOut.where(:serial => pp.serial ,:store_area_id=> pp.store_area_id ,:level => pp.level )
                              .where(:save_date => pp.save_date)
                             #.where(:serial => pp.serial)

      other_pio.each do |o_p|

            # logger.info  "====  other_pio  id = #{o_p.id}  serial = #{pp.serial}"

            if o_p.in_or_out == 'reduce'
                pio_reduce += o_p.num.to_i
            end

            if o_p.in_or_out == 'add'
                pio_add += o_p.num.to_i
            end
      end

      _gg = (pio_add - pio_reduce)
      # logger.info  "--------------  #{_gg}  serial = #{pio_add} - #{pio_reduce} "

      if (1 <= _gg.to_i)

          pio_str += "<option value=#{pp.serial} alt=#{pp.serial}/#{pp.store_area_id}/#{pp.level}/#{pp.save_date} > #{pp.serial} </option>"
          #pio_add_ary[pp.id]        =  "#{(pio_add - pio_reduce)}"
      end

    end
    render :text => pio_str
    # render :text => "#{pio_add_ary}"
  end


  def p_good_or_not
    para    = params[:id].split('/')
    paola   = ProductInOut.where(:level=>para[2] ).first

    render :text => "<option value=#{paola.level}> #{paola.level}</option>"

  end

  def p_store_area
    # paola   = ProductInOut.find_by_serial(params[:id])
    para    = params[:id].split('/')
    paola   = ProductInOut.where(:store_area_id=>para[1] ).first

    render :text => "<option value=#{paola.store_area_id}> #{paola.store_area.area_name}</option>"
  end


  def inp_save_date
    para      =   params[:id].split('/')
    paola     =   ProductInOut.where(:save_date => para[3]).first
    # paola   =   ProductInOut.find_by_serial(params[:id])
    d = paola.save_date
    render :text => d.strftime("%Y-%m-%d")
  end

  def inp_save_num
    para    = params[:id].split('/')
    paola   = ProductInOut.where(:serial=>para[0] ,:store_area_id=>para[1] ,:level=>para[2] )
                          .where(:save_date => para[3])
    # logger.info  "#{para}"
    # logger.info  "--------#{para[0]}/#{para[1]}/#{para[2]}--#{para[3]}------"

    padd = 0
    preduce = 0

    paola.each do |pa|
      logger.info  "#{pa.id}"
      if pa.in_or_out == 'add'
        padd += pa.num
      end

      if pa.in_or_out == 'reduce'
        preduce += pa.num
      end

    end


    render :text => "剩餘的數量<font color=blue>#{padd-preduce}</font>"

  end



  def json_product_id
    
  end


end
