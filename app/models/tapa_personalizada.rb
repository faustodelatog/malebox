class TapaPersonalizada

  attr_accessor :tapa
  attr_accessor :variables

  def initialize(tapa_id, variables)
  	self.tapa = Tapa.find(tapa_id)
  	self.variables = variables
  end
end