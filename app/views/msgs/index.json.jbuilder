json.array!(@msgs) do |msg|
  json.extract! msg, :id, :title, :contetn, :state
  json.url msg_url(msg, format: :json)
end
