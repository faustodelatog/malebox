class InventarioCosa < ActiveRecord::Base
  enum inventario: [:sanfer]
  belongs_to :cosa

  validates :cosa_id, uniqueness: { scope: :inventario }

  def agregar(cantidad, notas)
  	registro = InventarioCosaRegistro.new({inventario_cosa_id: id, notas: notas, cantidad:cantidad})
  	registro.ingreso!

  	registro.save!

  	self.cantidad += cantidad
  	self.save!
  end

  def quitar(cantidad, notas)
  	registro = InventarioCosaRegistro.new({inventario_cosa_id: id, notas: notas, cantidad:cantidad})
  	registro.salida!

  	registro.save!

  	self.cantidad -= cantidad
  	self.save!
  end

  def nombre
  	"(#{inventario}) #{cosa.nombre}"
  end
end
