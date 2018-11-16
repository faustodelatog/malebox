class CreateCosas < ActiveRecord::Migration
  def change
    create_table :cosas do |t|
      t.string :nombre
      t.string :url

      t.timestamps null: false
    end
  end
end
