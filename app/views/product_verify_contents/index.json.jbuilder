json.array!(@product_verify_contents) do |product_verify_content|
  json.extract! product_verify_content, :id
  json.url product_verify_content_url(product_verify_content, format: :json)
end
