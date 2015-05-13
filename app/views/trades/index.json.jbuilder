json.array!(@trades) do |trade|
  json.extract! trade, :id, :description, :
  json.url trade_url(trade, format: :json)
end
