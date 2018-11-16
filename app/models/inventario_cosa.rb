class InventarioCosa < ActiveRecord::Base
  enum inventario: [:sanfer]
  belongs_to :cosa

  def nombre
  	"(#{inventario}) #{cosa.nombre}"
  end
end
