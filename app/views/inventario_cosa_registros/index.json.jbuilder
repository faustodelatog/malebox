json.array!(@inventario_cosa_registros) do |inventario_cosa_registro|
  json.extract! inventario_cosa_registro, :id, :inventario_cosa_id, :tipo, :cantidad, :notas
  json.url inventario_cosa_registro_url(inventario_cosa_registro, format: :json)
end
