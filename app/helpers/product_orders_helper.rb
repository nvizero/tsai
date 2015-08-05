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

end
