json.array!(@product_orders) do |product_order|
  json.extract! product_order, :id, :code, :order_state_id, :member_id, :state
  json.url product_order_url(product_order, format: :json)
end
