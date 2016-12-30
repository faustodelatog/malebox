class AddSectorEntregaToPedido < ActiveRecord::Migration
  def change
    add_column :pedidos, :sector_entrega, :string, default:'UIO'
  end
end
