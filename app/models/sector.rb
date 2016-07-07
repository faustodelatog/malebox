class Sector

  attr_accessor :id
  attr_accessor :nombre
  attr_accessor :costo

  def initialize id, nombre, costo
    self.id = id
    self.nombre = nombre
    self.costo = costo
  end

  def self.quito
    [
      Sector.new('NQ', 'Norte', 2.98),
      Sector.new('CCQ', 'Carapungo - Calderón', 5.98),
      Sector.new('SQ', 'Sur', 5.98),
      Sector.new('CQ', 'Centro', 2.98),
      Sector.new('CHQ', 'Los Chillos', 6.98),
      Sector.new('CBQ', 'Cumbayá', 6.98),
    ]
  end

  def quito?
    Sector.quito.select{|s| s.id.eql?(self.id)}.any?
  end

  def self.find id
    result = Sector.quito.select{|s| s.id.eql?(id)}.first
    result = Sector.new('O', 'Otro', 7.98) if !result

    result
  end

end