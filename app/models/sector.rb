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
      Sector.new('PD', 'Punto de Distribución San Fernando', 0),
      Sector.new('NQ', 'Norte Quito', 2.98),
      Sector.new('CCQ', 'Mitad del Mundo - Carcelén - Carapungo - Calderón', 6.98),
      Sector.new('SQC', 'Sur hasta Chillogallo', 5.98),
      Sector.new('SQG', 'Guamaní', 8.98),
      Sector.new('CQ', 'Centro Histórico', 5.98),
      Sector.new('CHQ', 'Sangolquí', 8.98),
      Sector.new('CBQ', 'Nayon - Cumbayá', 6.98),
      Sector.new('CT', 'Tumbaco - Lumbisí', 8.98),
      Sector.new('CVQ', 'Conocoto - San Rafael', 6.98),
      Sector.new('AQ', 'Tababela', 15.98),
      Sector.new('AMG', 'Amaguaña', 15.98),
    ]
  end

  def quito?
    Sector.quito.select{|s| s.id.eql?(self.id)}.any?
  end

  def self.find id
    result = Sector.quito.select{|s| s.id.eql?(id)}.first
    result = Sector.new('O', 'Provincia', 5.98) if !result

    result
  end

end