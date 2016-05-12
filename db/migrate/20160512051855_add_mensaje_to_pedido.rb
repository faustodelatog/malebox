class AddMensajeToPedido < ActiveRecord::Migration
  def change
    add_column :pedidos, :mensaje, :text
  end
end
