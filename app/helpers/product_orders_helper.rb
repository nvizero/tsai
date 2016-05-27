module ProductOrdersHelper

  def search_wait_order code

    obps = WaitOrder.where( :code => code )

    #
    # pio     =   WaitOrder.where( :code => code )
    #                      .select("wait_orders count(*) as total")
    #                      .joins("JOIN product_in_outs.wait_order_id = wait_orders.id")

    # pio    = WaitOrder.select("sum(product_in_out.num) as total")
    #                   .joins(:product_in_out)

    # not_show = []
    # pios_sum = 0
    #
    # obps.each do |obp|
    #
    #     pios = ProductInOut.where(:wait_order_id=>obp.id)
    #     pios.each do |pio|
    #         pios_sum += pio.num.to_i
    #     end
    #
    #     if  (pios_sum.to_i - obp.num.to_i) == 0
    #       not_show[] = obp.id
    #     end
    # end

    return obps
  end

  #搜尋商品名稱
  def search_wait_order_for_sale code , produce_name

      sql   = " SELECT "+
              " `wait_orders`.`id` , "+
              " `wait_orders`.`num` , "+
              " `wait_orders`.`price` , "+
              " `wait_orders`.`code` , "+
              " `products`.`title` , "+
              " `products`.`code`  ,"+
              " `wait_orders`.`total`  "+

              " FROM wait_orders " +
              " LEFT JOIN products ON " +
              " wait_orders.product_id = products.id " +
              " where `wait_orders`.`code` = '" + "#{code}" + "' "+
              " AND "+
              " `products`.`title` like '" + "%#{produce_name}%" + "' "


      obps = ActiveRecord::Base.connection.execute(sql)
      return obps

  end


  def just_wait_order_for_sale code

      sql   = " SELECT "+
              " `wait_orders`.`id` , "+
              " `wait_orders`.`num` , "+
              " `wait_orders`.`price` , "+
              " `wait_orders`.`code` , "+
              " `products`.`title` , "+
              " `products`.`code`  "+

              " FROM wait_orders " +
              " LEFT JOIN products ON " +
              " wait_orders.product_id = products.id " +
              " where `wait_orders`.`code` = '" + "#{code}" + "' "+


      obps = ActiveRecord::Base.connection.execute(sql)
      return obps

  end



  def check_wait_order_show wait_order_id
        empty = 0
        flag  = true
        pios   = ProductInOut.where(:wait_order_id => wait_order_id.to_i)

        pios.each do |pio|
            empty+=pio.num
        end
        #
        # if !pio.id.nil?
        #
        #     flag = true
        #
        # else
        #
        #     flag = false
        #
        # end

        return empty

  end

  def get_all_total_price

      obps = WaitOrder.all
      all_total_price = 0
      obps.each do |ob|
        all_total_price += ( ob.num.to_i * ob.price.to_i )
      end

      return all_total_price

  end


  def get_product id
     pro = Product.find(id)
     return pro
  end
end
