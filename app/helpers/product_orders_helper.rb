module ProductOrdersHelper

  def search_wait_order code
    obps = WaitOrder.where( :code => code )
    return obps
  end

end
