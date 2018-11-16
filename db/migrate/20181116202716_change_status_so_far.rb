class ChangeStatusSoFar < ActiveRecord::Migration
  def change
  	Pedido.where("estado ilike 'PENDIENTE'").where('fecha_entrega < (?)', Date.today).update_all(estado: 'ENTREGADO')
  	Pedido.where("estado ilike 'PAGADO/ENTREGADO'").update_all(estado: 'ENTREGADO')
  	Pedido.where("estado ilike 'RESERVA'").update_all(estado: 'ENTREGADO')
  	Pedido.where("estado ilike 'PAGADO / POR ENTREGAR'").update_all(estado: 'PAGADO')
  	Pedido.where("estado ilike 'PAGADO PAYPAL%'").update_all(estado: 'PAGADO PAYPAL')
  end
end
