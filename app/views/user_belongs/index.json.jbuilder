json.array!(@user_belongs) do |user_belong|
  json.extract! user_belong, :id, :user_id, :belong_user_id
  json.url user_belong_url(user_belong, format: :json)
end
