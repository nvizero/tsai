json.array!(@product_verifies) do |product_verify|
  json.extract! product_verify, :id, :product_id, :status, :product_verify_type_id
  json.url product_verify_url(product_verify, format: :json)
end
