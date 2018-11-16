class Inventario
	attr_accessor :inventario_id
	def initialize(inventario_id)
		self.inventario_id = inventario_id
	end

	def agregar_cosas(cosa_id, cantidad, notas)
		inventario_cosa = InventarioCosa.find_by(cosa_id: cosa_id, inventario: self.inventario_id)
		inventario_cosa.agregar(cantidad, notas)
	end

	def quitar_cosas(cosa_id, cantidad, notas)
		inventario_cosa = InventarioCosa.find_by(cosa_id: cosa_id, inventario: self.inventario_id)
		inventario_cosa.quitar(cantidad, notas)
	end

	def quitar_cosas_de_producto(producto_id, notas)
		Producto.producto_cosas.each{|c| quitar_cosas(c.cosa_id, c.cantidad || 1, notas)}
	end
end