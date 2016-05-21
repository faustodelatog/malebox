class AddFormaPagoToPedido < ActiveRecord::Migration
  def change
    add_column :pedidos, :forma_pago, :string, default: 'T'
  end
end
