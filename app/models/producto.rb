class Producto < ActiveRecord::Base
  has_many :fotos, :dependent => :delete_all
  has_many :categoria_productos, :dependent => :delete_all
  has_many :categoria, :through => :categoria_productos
  has_many :producto_cosas, :dependent => :delete_all

  belongs_to :empaque, required: false

  def precio_original
  	(precio * 1.06).round(0)
  end


  def precio_d
    '%.2f' % self.precio
  end

  def nombreCiudadesMismoDia
  	ciudadesMismoDia.split("-").map {|inicialesCiudad| Ciudad.find(inicialesCiudad)}
  end

  def permite_tapa_personalizada
    categorias = CategoriaProducto.where("producto_id = ?", id).map{ |cp| cp.categorium }
    # se permite tapa personalizada para wood box (categoria 4) y cajas específicas 
    return categorias.any?{|c| c.id == 4} && ![249, 114, 149, 69, 244, 216].include?(id)
  end

  def quitar_de_inventario (inventario_id, pedido_id, producto_cosas_ids)
    producto_cosas.
      select{|pc| producto_cosas_ids.include?(pc.id)}.
      each{|c| c.quitar_de_inventario(inventario_id, pedido_id)}
  end
end
