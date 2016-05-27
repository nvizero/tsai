json.array!(@product_verify_states) do |product_verify_state|
  json.extract! product_verify_state, :id, :title, :create_user_id, :modify_user_id, :stoped_user_id, :stoped_at
  json.url product_verify_state_url(product_verify_state, format: :json)
end
