class CreateProductoCosas < ActiveRecord::Migration
  def change
    create_table :producto_cosas do |t|
      t.references :cosa, index: true, foreign_key: true
      t.references :producto, index: true, foreign_key: true
      t.integer :cantidad

      t.timestamps null: false
    end
  end
end
