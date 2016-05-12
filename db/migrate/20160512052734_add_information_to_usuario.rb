class AddInformationToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :nombre, :string
    add_column :usuarios, :apellido, :string
    add_column :usuarios, :fecha_nacimiento, :date
  end
end
