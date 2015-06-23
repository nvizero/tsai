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

    member_id = params[:member_id]
    code = params[:code]
    p_str = params[:p_str]

    order_flag = true

    qq = ''

    p_str.split('/').each do |pr|

      product_num   = pr.split(',')
      product_id    = product_num[0].split('p_')


      OrderByProduct.create(:product_id => product_id[1],
                            :num => product_num[1],
                            :code=>code)


    end



    if order_flag
      ProductOrder.create(  :order_state_id=>1,
                            :state=>'Y',
                            :member_id => member_id,
                            :code=>code)
    else
      order_flag = false
    end

    render :text => order_flag

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
    #  new p_2,/",
    #  update"=>"9,55/10,33/",
    member_id = params[:member_id]
    code = params[:code]

    d_new     = params[:new]
    d_update  = params[:update]
    dduu = ''
    #新增的
    d_new.split('/').each do |new_one|
      product_num   = new_one.split(',')
      product_id    = product_num[0].split('p_')
      OrderByProduct.create(:product_id => product_id[1],
                            :num => product_num[1],
                            :code=>code)
    end

    #更新
    d_update.split('/').each do |up_date|

      pInfo   = up_date.split(',')
      dduu += "#{pInfo[0]}- #{pInfo[1]} "

      # product_id    = product_num[0].split('p_')
      obp = OrderByProduct.find(pInfo[0].to_i)
      obp.num =pInfo[1].to_i
      obp.save

    end

    render :text => 'true'
  end
end
