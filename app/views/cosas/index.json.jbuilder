json.array!(@cosas) do |cosa|
  json.extract! cosa, :id, :nombre, :url
  json.url cosa_url(cosa, format: :json)
end
