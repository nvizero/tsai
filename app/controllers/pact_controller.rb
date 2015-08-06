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


  def search_member_name

      aMember = Member.where(:name => params[:name]).first
      if !aMember.nil?
          # render :text => "#{aMember.name}/#{aMember.name.length}"
          render :text => "#{aMember.id}"
      else
          render :text => false
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
                            :total => total_price,
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

        # "users.name = ? OR users.name = ?", request.requester, request.regional_sales_mgr)
        # orderPro = OrderByProduct.where(:product_id => product_id,:code  => code)
        # logger.info  "--------#{code} , #{product_id}------ "

        orderPro = OrderByProduct.where(:code =>code ,  :product_id => product_id).first

        if !orderPro.nil?

            orderPro.num   =  product_num
            orderPro.price =  product_price
            orderPro.total =  product_total.to_i
            orderPro.modify_user_id = session[:user_id]
            orderPro.save

        else

            OrderByProduct.create(:product_id     => product_id,
                                  :num            => product_num,
                                  :price          => product_price,
                                  :total          => (product_num.to_i * product_price.to_i),
                                  :code           => code,
                                  :create_user_id => session[:user_id] )
        end

        # OrderByProduct.create(:product_id => product_id,
        #                       :num   => product_num,
        #                       :price => product_price,
        #                       :total => total_price,
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
      proOrder.total = total_price.to_i
      proOrder.future_day = dataInfo[0]
      proOrder.pay_type_id = dataInfo[2].to_i
      proOrder.order_day = dataInfo[3]
      proOrder.modify_user_id = session[:user_id]
      proOrder.save

    end
    render :text => order_flag

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
      # logger.info  "#{pa.id}"
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

  def product_list_code
      if params[:type] == 'code'

          if !params[:old_data].nil?
            @products = Product.where("code like ?", "%#{params[:code]}%").where.not(code: params[:old_data].split(',') )
          else
            @products = Product.where("code like ?", "%#{params[:code]}%")
          end

      elsif params[:type] == 'title'

        if !params[:old_data].nil?
          @products = Product.where("title like ?", "%#{params[:title]}%").where.not(title: params[:old_data].split(',') )
        else
          @products = Product.where("title like ?", "%#{params[:title]}%")
        end

      end

  end


  def member_list

      if params[:name]
        @members = Member.where("name like ?", "%#{params[:name]}%").limit(20)
      else
        @members = Member.limit(20)
      end

  end

  def get_random_str
      o = [ ('a'..'z'),('1'..'9'),('A'..'Z') ].map { |i| i.to_a }.flatten
      cg = (0...5).map { o[rand(o.length)] }.join
      render :text => cg
  end



  #只是測試用
  def tgroup
    cc=ProductInOut.group(:code).count
    tttxg  = "#{cc.size}<br><br>"
    tttxg += "<table border=1>"
    i = 1

     pios = ProductInOut
            .select("product_in_outs.id, product_in_outs.code, SUM(product_in_outs.num) as sum_num")
            .group("product_in_outs.in_or_out")
            .order("product_in_outs.id")

    pios.each do |pio|
        tttxg += "<tr>"
        tttxg += "<td>#{i}</td>"

        tttxg += "<td>#{pio.code}</td>"
        tttxg += "<td>#{pio.sum_num}</td>"
        tttxg += "</tr>"
        i     += 1
    end
    tttxg+="</table>"
    render :text =>tttxg

  end



  def search_product_info
    logger.info  "#{params}"
    if params[:type] == 'code'

          proInfo = Product.where(:code => params[:code]).first

          if proInfo
            render :text => "#{proInfo.code}/#{proInfo.title}"
          else
            render :text => false
          end

    elsif  params[:type] == 'name'

          proInfo = Product.where(:title => params[:name]).first

          if proInfo
            render :text => "#{proInfo.code}/#{proInfo.title}"
          else
            render :text => false
          end
    end

  end

  def find_member_name
      memInfo = Member.where(:name=>params[:name]).first
      if memInfo
        render :text=> memInfo.id
      else
        render :text=> false
      end
  end


  def product_order_confirm

      product_order = ProductOrder.find(params[:product_order_id])
      product_order.confirm_order = 'Y'
      if product_order.save
          render :text => true
      else
          render :text => false
      end

  end

  def post_to_out_order

    wo = WaitOrder.find(params[:order_by_product_id])
    if wo

         io_str = "\n"
         proInfo_str = "\n"
         #算庫存
         add , reduce , final = self.product_stock(wo)

        #  render :text => "#{add} \n -#{reduce} \n final = #{final}"
        if wo.num.to_i > final.to_i
            render :text => false
        else
            pioInfo = self.product_out(wo)

            render :text => "+ #{add} \n "     +
                            "- #{reduce} \n "  +
                            "final=#{final} \n" +
                            "#{pioInfo.id} \n"  +
                            "pioInfo.num = #{pioInfo.num} "
        end
    else
        render :text => "false"
    end

  end


  def product_order_confirm_check

    product_order = ProductOrder.find(params[:product_order_id])
    # logger.info  "--------#{params[:product_order_id]}------"
    if product_order.confirm_order == 'Y'

        obps = OrderByProduct.where(:code =>product_order.code )
        # logger.info  "---product_order.code-----#{product_order.code}------"
        # render :text =>'qweqwe'
        obps.each do |obp|
              # logger.info  "---obp.id-----#{obp.id}------"
              WaitOrder.create( :product_id => obp.product_id ,
                                :create_user_id => session[:user_id],
                                # :serial  =>  pio.serial ,
                                :state   =>  'Y' ,
                                :num  =>  obp.num.to_i,
                                :price  => obp.price.to_i,
                                :total  => (obp.num.to_i * obp.price.to_i ) ,
                                :code => obp.code
                                )
        end
    end
    render :text =>true
  end


end
