class Station

  attr_reader :name, :trains

  @@instances = 0

  def self.all
    @@instances
  end

  def initialize(name)
    @trains = []
    @name = name
    @@instances += 1
  end

  def take_train(train)
    self.trains << train
  end

  def send_train(train)
    self.trains.delete(train)
  end

  def trains_typeof(type)
      self.trains.filter {|train| train.type == type}
  end

  def to_s
    puts self.name
  end
  #В поле private были вынесены данные сеттеры так как они используются только при создании объекта, в конструкторе
  private
  attr_writer :name, :trains

end
