json.array!(@dailies) do |daily|
  json.extract! daily, :id, :day, :type, :title, :content, :created_user_id, :modify_user_id, :stoped_at, :stop_user_id
  json.url daily_url(daily, format: :json)
end
