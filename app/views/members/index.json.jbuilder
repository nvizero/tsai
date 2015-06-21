json.array!(@members) do |member|
  json.extract! member, :id, :name, :tel, :address, :state
  json.url member_url(member, format: :json)
end
