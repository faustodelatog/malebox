class AddInstruccionesEntregaToPedido < ActiveRecord::Migration
  def change
    add_column :pedidos, :instrucciones_entrega, :text
  end
end
