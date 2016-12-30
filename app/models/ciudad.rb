class Ciudad

  attr_accessor :id
  attr_accessor :nombre
  attr_accessor :foto

  def initialize id, nombre, foto
    self.id = id
    self.nombre = nombre
    self.foto = foto
  end

def self.todas
    [
      Ciudad.new('UIO', 'Quito', 'http://www.comprarbanderas.es/images/banderas/400/2131-quito_400px.jpg'),
      Ciudad.new('CUE', 'Cuenca', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Flag_of_Cuenca,_Ecuador.svg/200px-Flag_of_Cuenca,_Ecuador.svg.png'),
    ]
end

def self.find id
    result = Ciudad.todas.select{|s| s.id.eql?(id)}.first
    result = Ciudad.new('UIO', 'Quito', '') if !result

    result
  end
end