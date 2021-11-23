require_relative 'modules/instance_counter'
require_relative 'modules/validation_check'
class Station
  include ValidationCheck
  include InstanceCounter

  attr_reader :name, :trains
  @@stations = {}

  def self.all
    @@stations
  end

  def each_train
    yield self.trains
  end

  def initialize(name)
    @trains = []
    @name = name
    validate!
    @@stations[name] = self
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
  def validate!
    raise "Station name can only contains latin symbols!" if self.name !~ NAME_FORMAT
    raise "This station already exist" if @@stations.keys.include? self.name
  end
  NAME_FORMAT = /\w+/i
end
