json.array!(@spaces) do |space|
  json.extract! space, :id, :title, :details, :expected_completion_date, :tenant_id
  json.url space_url(space, format: :json)
end
