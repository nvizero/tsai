json.array!(@verify_type_mains) do |verify_type_main|
  json.extract! verify_type_main, :id, :title, :content
  json.url verify_type_main_url(verify_type_main, format: :json)
end
