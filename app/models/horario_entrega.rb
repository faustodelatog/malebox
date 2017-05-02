class HorarioEntrega

  attr_accessor :id
  attr_accessor :nombre
  attr_accessor :costo

  def initialize id, nombre, costo
    self.id = id
    self.nombre = nombre
    self.costo = costo
  end

  def self.todos
    [
      HorarioEntrega.new('1', '7:30 - 10:00', 0),
      HorarioEntrega.new('2', '10:00 - 13:00', 0),
      HorarioEntrega.new('3', '14:00 - 18:00', 0),
    ]
  end

  def self.find id
    result = HorarioEntrega.todos.select{|s| s.id.eql?(id)}.first
    result = HorarioEntrega.new('O', 'Cualquier momento', 0) if !result

    result
  end

end