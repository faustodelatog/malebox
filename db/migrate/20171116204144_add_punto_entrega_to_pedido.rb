class AddPuntoEntregaToPedido < ActiveRecord::Migration
  def change
    add_column :pedidos, :punto_entrega, :string
  end
end
