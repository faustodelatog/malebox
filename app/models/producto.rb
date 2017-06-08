class Producto < ActiveRecord::Base
  has_many :fotos, :dependent => :delete_all
  has_many :categoria_productos, :dependent => :delete_all
  has_many :categoria, :through => :categoria_productos

  def precio_original
  	(precio * 1.12).round(2)
  end

  def nombreCiudadesMismoDia
  	ciudadesMismoDia.split("-").map {|inicialesCiudad| Ciudad.find(inicialesCiudad)}
  end
end
