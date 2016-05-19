class AddOrdenToProducto < ActiveRecord::Migration
  def change
    add_column :productos, :orden, :integer, default:10000
  end
end
