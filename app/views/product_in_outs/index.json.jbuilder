json.array!(@product_in_outs) do |product_in_out|
  json.extract! product_in_out, :id, :product_id, :code, :num, :in_or_out, :create_user_id, :modify_user_id, :stop_user_id, :stoped_at
  json.url product_in_out_url(product_in_out, format: :json)
end
