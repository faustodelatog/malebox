class AddCantidadMinimaToCosa < ActiveRecord::Migration
  def change
    add_column :cosas, :cantidad_minima, :integer
  end
end
