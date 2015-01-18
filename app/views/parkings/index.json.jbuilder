json.array!(@parkings) do |parking|
  json.extract! parking, :id, :name, :address, :lon, :lat, :price, :total, :taken
  json.url parking_url(parking, format: :json)
end
