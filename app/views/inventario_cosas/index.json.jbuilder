json.array!(@inventario_cosas) do |inventario_cosa|
  json.extract! inventario_cosa, :id, :cosa_id, :inventario, :cantidad
  json.url inventario_cosa_url(inventario_cosa, format: :json)
end
