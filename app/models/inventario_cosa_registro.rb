class InventarioCosaRegistro < ActiveRecord::Base
  enum tipo: [ :ingreso, :salida ]
  belongs_to :inventario_cosa
end
