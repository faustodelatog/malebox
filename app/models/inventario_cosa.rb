class InventarioCosa < ActiveRecord::Base
  enum inventario: [:sanfer]
  belongs_to :cosa

  validates :cosa_id, uniqueness: { scope: :inventario }

  def agregar(cantidad, notas)
  	registro = InventarioCosaRegistro.new({inventario_cosa_id: id, notas: notas, cantidad:cantidad})
  	registro.ingreso!

  	registro.save!

  	self.cantidad += cantidad.to_i
  	self.save!
  end

  def quitar(cantidad, notas)
  	registro = InventarioCosaRegistro.new({inventario_cosa_id: id, notas: notas, cantidad:cantidad})
  	registro.salida!

  	registro.save!

  	self.cantidad -= cantidad.to_i
  	self.save!
  end

  def nombre
  	"(#{inventario}) #{cosa.nombre}"
  end

  def salud_i
    cantidad_minima = cosa.cantidad_minima || 0
    self.cantidad - cantidad_minima
  end

  def salud
    cantidad_minima = cosa.cantidad_minima || 0
    return 'green' if cantidad > cantidad_minima
    return 'orange' if cantidad <= cantidad_minima && cantidad > 0
    return 'red' if cantidad == 0
    return 'black' if cantidad < 0
  end
end
