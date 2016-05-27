json.array!(@id_seqs) do |id_seq|
  json.extract! id_seq, :id, :pre_id, :seq
  json.url id_seq_url(id_seq, format: :json)
end
