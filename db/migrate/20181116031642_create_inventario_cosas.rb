class CreateInventarioCosas < ActiveRecord::Migration
  def change
    create_table :inventario_cosas do |t|
      t.references :cosa, index: true, foreign_key: true
      t.integer :inventario
      t.integer :cantidad

      t.timestamps null: false
    end
  end
end
