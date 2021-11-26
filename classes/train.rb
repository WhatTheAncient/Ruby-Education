require_relative 'modules/manufacturer'
require_relative 'modules/instance_counter'
require_relative 'modules/validation_check'
class Train
  include ValidationCheck
  include Manufacturer
  include InstanceCounter
  attr_reader :id, :type, :speed, :current_station, :route, :wagons

  @@trains = {}

  def self.find(id)
    @@trains[id]
  end

  def initialize(id, type)
      @type = type
      @id = id
      validate!
      @wagons = {}
      @speed = 0
      @route = nil
      @current_station = nil
      register_instance
      @@trains[id] = self
  end

  def each_wagon (&block)
    self.wagons.values.each &block
  end

  def add_wagon(wagon)
    self.wagons[wagon.id] = wagon if (self.type.to_s == wagon.type.to_s && speed == 0)
  end

  def remove_wagon(wagon_id)
    self.wagons.delete(wagon_id) if speed == 0
  end

  def to_s
    "Number: #{ self.id }, Type: #{self.type}. Count of wagons: #{self.wagons.size}"
  end

  def set_route(route)
    self.route = route
    self.current_station = route.stations.first
    self.current_station.take_train(self)
  end

  def move_fd
    if next_station
      self.current_station.send_train(self)
      self.speed = 50
      self.current_station = next_station
      self.current_station.take_train(self)
      self.stop
    end
  end

  def move_back
    if previous_station
      self.current_station.send_train(self)
      self.speed = 50
      self.current_station = previous_station
      self.current_station.take_train(self)
      self.stop
    end
  end

  #Данные атрибуты и методы вынесены в protected так как они используются только внутри класса
  protected
  ID_FORMAT = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i
  TYPE_FORMAT = /^[a-z]+$/i
  attr_writer :id, :type, :speed, :wagons, :current_station, :route

  def validate!
    raise "Invalid train number. It should contain 3 digits or characters, optional dash and 2 digits or characters again" if self.id !~ ID_FORMAT
    raise "Train type can only contain latin symbols!" if self.type !~ TYPE_FORMAT
  end

  def next_station
    unless self.current_station.name == route.stations.last.name
      self.route.stations[self.route.stations.find_index(self.current_station) + 1]
    end
  end

  def previous_station
    unless self.current_station.name == route.stations.first.name
      self.route.stations[self.route.stations.find_index(self.current_station) - 1]
    end
  end

  def stop
    self.speed = 0
  end
end
