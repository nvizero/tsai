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


end
