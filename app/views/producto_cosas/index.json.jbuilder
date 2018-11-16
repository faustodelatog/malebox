json.array!(@producto_cosas) do |producto_cosa|
  json.extract! producto_cosa, :id, :cosa_id, :producto_id, :cantidad
  json.url producto_cosa_url(producto_cosa, format: :json)
end
