class CreateTapas < ActiveRecord::Migration
  def change
    create_table :tapas do |t|
      t.string :nombre
      t.string :url
      t.string :categoria
      t.string :descripcion
      t.string :variables

      t.timestamps null: false
    end
  end
end
