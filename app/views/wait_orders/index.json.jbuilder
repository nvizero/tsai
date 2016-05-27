json.array!(@wait_orders) do |wait_order|
  json.extract! wait_order, :id, :product_id, :code, :num, :state, :create_user_id, :modify_user_id, :stop_user_id, :stoped_at, :serial, :save_date
  json.url wait_order_url(wait_order, format: :json)
end
