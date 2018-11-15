json.array!(@tapas) do |tapa|
  json.extract! tapa, :id, :nombre, :url, :categoria, :descripcion, :variables
  json.url tapa_url(tapa, format: :json)
end
