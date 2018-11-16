json.array!(@empaques) do |empaque|
  json.extract! empaque, :id, :nombre, :url
  json.url empaque_url(empaque, format: :json)
end
