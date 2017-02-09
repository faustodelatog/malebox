class AddDeYParaToPedidos < ActiveRecord::Migration
  def change
    add_column :pedidos, :de, :text
    add_column :pedidos, :para, :text
  end
end
