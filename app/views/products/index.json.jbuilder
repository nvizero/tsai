json.array!(@products) do |product|
  json.extract! product, :id, :title, :content, :num, :user_id
  json.url product_url(product, format: :json)
end
