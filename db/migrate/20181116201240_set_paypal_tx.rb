class SetPaypalTx < ActiveRecord::Migration
  def change
  	Pedido.where("estado ilike 'PAGADO PAYPAL%'").each do |p|
  		p.paypal_tx = p.estado
  		p.estado = 'Pagado PayPal'
  		p.save!
	end
  end
end
