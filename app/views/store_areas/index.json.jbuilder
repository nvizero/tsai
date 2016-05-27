json.array!(@store_areas) do |store_area|
  json.extract! store_area, :id, :area_id, :area_name
  json.url store_area_url(store_area, format: :json)
end
