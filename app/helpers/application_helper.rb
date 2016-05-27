module ApplicationHelper

  def s_show

  end

  def appli_helper_access(obj)
    render :text => "#{obj.id}"
    # render :text => user.forget_pas
  end

  #網址第三個
  def get_url_3
    request.original_url.split('/')[3]
  end

  def get_role_access
     Role.find(session[:user_role_id])
  end

  def get_user_access
     session[:user["access"]]
  end

  #判斷權限
  def judgment_access _str
    #判斷是否ALL
    if session[:user["access"]]

      if session[:user["access"]] == 'all'

        return true

      else

        if session.nil?
          return false
        end

        judge_flag = false
        session[:user["access"]].split(',').each do |ja|
            if ja.to_s.start_with? _str
              judge_flag = true
            end
        end

        return judge_flag

      end

    else
      return true
    end

  end

  #只是顯示
  def show_session
    # session[:user["access"]]
    !session.nil?
  end



  def role_checkbox text , num
    check_flag = false
    text.to_s.split(',').each do |str|
      if str.to_i == num.to_i
        check_flag = true
      end
    end

    if check_flag
      return 'CHECKED'
    else
      return ''
    end
  end


  def check_user_is_new user
    if user.id
      false
    else
      true
    end
  end






  def state_n_show obj , content
    if obj.state == 'N'
      simple_format "#{content}"
    else
      simple_format "#{content}"
    end
  end


  def show_se_user

    session[:user_id]
  end



  #商品入庫出貨計算 且 狀態要為Y
  def in_out_cal obj

    @in_num = 0
    @out_num = 0


    obj.each do |pio|
        #入庫 且 pio.in_come_check 要等於 'Y'
        if pio.in_or_out == 'add' && pio.state == 'Y' && pio.in_come_check == 'Y'
            @in_num += pio.num.to_i
        end

        #出貨 且 pio.in_come_check 要等於 'Y'
        if pio.in_or_out == 'reduce' && pio.state == 'Y' && pio.in_come_check == 'Y'
            @out_num += pio.num.to_i
        end

    end

  end


  def get_random_str num
      o = [('a'..'z'), ('1'..'9'),('A'..'Z') ].map { |i| i.to_a }.flatten
      cg = (0...num).map { o[rand(o.length)] }.join
      return cg
  end

  def get_random_date
      # cstr=self.get_random_str(3)
      cstr=''
      cstring = Time.now.strftime("%Y%m%d")
      return "#{cstring}#{cstr}"
  end


  def order_serial_code str_len
    ct = 5-str_len.to_i
    @cstr = ''
    ct.times do |ee|
      @cstr+='0'
    end
    return @cstr
  end



  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

end
