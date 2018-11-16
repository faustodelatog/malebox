class AddUniqueIndexToInventarioCosa < ActiveRecord::Migration
  def change
    add_index :inventario_cosas, [:inventario, :cosa_id], unique: true
  end
end
