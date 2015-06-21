json.array!(@order_by_products) do |order_by_product|
  json.extract! order_by_product, :id, :product_id, :product_order_id, :num
  json.url order_by_product_url(order_by_product, format: :json)
end
