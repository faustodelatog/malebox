class AddTelefonoReceptorToPedido < ActiveRecord::Migration
  def change
    add_column :pedidos, :telefono_receptor, :string
  end
end
