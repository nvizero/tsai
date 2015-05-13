json.array!(@users) do |user|
  json.extract! user, :id, :email, :address
  json.url user_url(user, format: :json)
end
