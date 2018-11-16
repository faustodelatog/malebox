class AddEmpaqueToProducto < ActiveRecord::Migration
  def change
    add_reference :productos, :empaque, index: true, foreign_key: true
  end
end
