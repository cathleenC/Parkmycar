json.array!(@users) do |user|
  json.extract! user, :id, :mail, :plate, :password
  json.url user_url(user, format: :json)
end
