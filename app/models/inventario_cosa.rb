class InventarioCosa < ActiveRecord::Base
  enum inventario: [:sanfer]
  belongs_to :cosa

  validates :cosa_id, uniqueness: { scope: :inventario }

  def nombre
  	"(#{inventario}) #{cosa.nombre}"
  end
end
