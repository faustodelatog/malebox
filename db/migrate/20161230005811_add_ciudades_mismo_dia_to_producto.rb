class AddCiudadesMismoDiaToProducto < ActiveRecord::Migration
  def change
  	add_column :productos, :ciudadesMismoDia, :string, default: "UIO"
  end
end
