class Station
  attr_accessor :name, :trains

  def initialize(name)
    @trains = []
    @name = name
  end

  def take_train(train)
    raise TypeError unless train.is_a? Train
    self.trains << train
  end

  def send_train(train)
    raise TypeError unless train.is_a? Train
    self.trains.delete(train)
  end

  def trains_typeof(type)
    if type == 'cargo' || type == 'passenger'
      typed_trains = []
      self.trains.each do |train|
          typed_trains << train if train.type == 'cargo'
      end
    else
      raise TypeError
    end
    return typed_trains
  end

  def to_s
    puts(self.name)
  end

end
