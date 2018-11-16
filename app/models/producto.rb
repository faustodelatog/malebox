class Producto < ActiveRecord::Base
  has_many :fotos, :dependent => :delete_all
  has_many :categoria_productos, :dependent => :delete_all
  has_many :categoria, :through => :categoria_productos
  has_many :producto_cosas

  belongs_to :empaque, required: false

  def precio_original
  	(precio * 1.06).round(2)
  end

  def nombreCiudadesMismoDia
  	ciudadesMismoDia.split("-").map {|inicialesCiudad| Ciudad.find(inicialesCiudad)}
  end

  def permite_tapa_personalizada
    categorias = CategoriaProducto.where("producto_id = ?", id).map{ |cp| cp.categorium }
    # se permite tapa personalizada para wood box (categoria 4) y cajas específicas 
    return categorias.any?{|c| c.id == 4} && ![249, 114, 149, 69, 244, 216].include?(id)
  end

  def quitar_de_inventario (inventario_id, pedido_id)
    producto_cosas.each{|c| c.quitar_de_inventario(inventario_id, pedido_id)}
  end
end
