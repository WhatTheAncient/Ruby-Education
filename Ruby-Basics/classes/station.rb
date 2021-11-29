require_relative 'modules/instance_counter'
require_relative 'modules/validation'
class Station
  include Validation
  include InstanceCounter

  attr_reader :name, :trains
  @@stations = {}

  def self.all
    @@stations
  end

  def each_train(&block)
    self.trains.each &block
  end

  def initialize(name)
    @trains = []
    @name = name
    @@stations[name] = self
  end

  NAME_FORMAT = /\w+/i

  validate :name, :format, NAME_FORMAT

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
    self.name
  end
  #В поле private были вынесены данные сеттеры так как они используются только при создании объекта, в конструкторе
  private

  attr_writer :name, :trains

end
