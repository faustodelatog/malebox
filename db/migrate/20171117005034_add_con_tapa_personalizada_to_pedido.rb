class AddConTapaPersonalizadaToPedido < ActiveRecord::Migration
  def change
    add_column :pedidos, :con_tapa_personalizada, :boolean, default: false
  end
end
