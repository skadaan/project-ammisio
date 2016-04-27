json.array!(@user_spaces) do |user_space|
  json.extract! user_space, :id, :space_id, :user_id
  json.url user_space_url(user_space, format: :json)
end
