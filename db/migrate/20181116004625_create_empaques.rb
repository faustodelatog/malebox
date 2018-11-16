class CreateEmpaques < ActiveRecord::Migration
  def change
    create_table :empaques do |t|
      t.string :nombre
      t.string :url

      t.timestamps null: false
    end
  end
end
