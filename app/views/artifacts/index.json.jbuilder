json.array!(@artifacts) do |artifact|
  json.extract! artifact, :id, :name, :key, :space_id
  json.url artifact_url(artifact, format: :json)
end
