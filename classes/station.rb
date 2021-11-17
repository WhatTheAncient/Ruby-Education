class Station
  attr_accessor :name, :trains

  def initialize(name)
    @trains = []
    @name = name
  end

  def take_train(train)
    self.trains << train
  end

  def send_train(train)
    self.trains.delete(train)
  end

  def trains_typeof(type)
    if type == 'cargo' || type == 'passenger'
      self.trains.each { |train| puts train if train.type == type}
    end
  end

  def to_s
    puts(self.name)
  end

end
