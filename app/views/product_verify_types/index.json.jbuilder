json.array!(@product_verify_types) do |product_verify_type|
  json.extract! product_verify_type, :id, :name, :content
  json.url product_verify_type_url(product_verify_type, format: :json)
end
