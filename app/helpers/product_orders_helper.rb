module ProductOrdersHelper

  def search_order_by_product code
    obps = OrderByProduct.where( :code => code )

    return obps
  end

end
