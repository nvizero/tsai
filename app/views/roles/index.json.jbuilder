json.array!(@roles) do |role|
  json.extract! role, :id, :title, :text
  json.url role_url(role, format: :json)
end
