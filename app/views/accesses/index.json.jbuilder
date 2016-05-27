json.array!(@accesses) do |access|
  json.extract! access, :id, :title, :code
  json.url access_url(access, format: :json)
end
