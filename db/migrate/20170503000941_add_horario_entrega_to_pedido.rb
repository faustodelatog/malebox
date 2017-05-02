class AddHorarioEntregaToPedido < ActiveRecord::Migration
  def change
  	add_column :pedidos, :horario_entrega, :string
  end
end
