json.array!(@in_out_types) do |in_out_type|
  json.extract! in_out_type, :id, :title, :type, :create_user_id, :modify_user_id, :stop_user_id, :stoped_at
  json.url in_out_type_url(in_out_type, format: :json)
end
