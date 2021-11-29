require_relative 'modules/manufacturer'
require_relative 'modules/instance_counter'
require_relative 'modules/validation'
require_relative 'modules/accessors'
class Train
  extend Accessors
  include Validation
  include Manufacturer
  include InstanceCounter
  attr_reader :id, :type, :speed, :route, :wagons
  attr_accessor_with_history :current_station
  @@trains = {}

  def self.find(id)
    @@trains[id]
  end

  def initialize(id, type)
      @type = type
      @id = id
      @wagons = {}
      @speed = 0
      @route = nil
      @current_station = nil
      register_instance
      @@trains[id] = self
  end
  ID_FORMAT = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i
  TYPE_FORMAT = /^[a-z]+$/i
  validate :id, :format, ID_FORMAT
  validate :type, :format, TYPE_FORMAT

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

  attr_writer :id, :type, :speed, :wagons,  :route

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
