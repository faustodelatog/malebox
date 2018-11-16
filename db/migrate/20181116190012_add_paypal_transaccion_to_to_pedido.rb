class AddPaypalTransaccionToToPedido < ActiveRecord::Migration
  def change
    add_column :pedidos, :paypal_tx, :string
  end
end
