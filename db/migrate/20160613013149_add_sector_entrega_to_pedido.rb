class AddSectorEntregaToPedido < ActiveRecord::Migration
  def change
    add_column :pedidos, :sector_entrega, :string
  end
end
