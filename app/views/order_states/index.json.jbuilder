json.array!(@order_states) do |order_state|
  json.extract! order_state, :id, :title, :state
  json.url order_state_url(order_state, format: :json)
end
