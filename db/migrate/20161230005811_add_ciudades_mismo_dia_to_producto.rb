class AddCiudadesMismoDiaToProducto < ActiveRecord::Migration
  def change
  	add_column :productos, :ciudadesMismoDia, :string
  end
end
