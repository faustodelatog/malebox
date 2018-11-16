class CreateInventarioCosaRegistros < ActiveRecord::Migration
  def change
    create_table :inventario_cosa_registros do |t|
      t.references :inventario_cosa, index: true, foreign_key: true
      t.integer :tipo
      t.integer :cantidad
      t.text :notas

      t.timestamps null: false
    end
  end
end
