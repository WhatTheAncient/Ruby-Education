require_relative 'modules/manufacturer'
require_relative 'modules/instance_counter'
class Train

  include Manufacturer
  include InstanceCounter

  attr_reader :id, :type, :speed, :current_station, :route, :wagons
  #Я вижу что строчка ниже общая для классов Поезд (а также его дочерних) Маршрут и Станция,
  # но я не смог найти способ запихнуть ее в модуль.
  # У меня есть идея как можно сделать общий модуль который будет реализовывать Train.find, Station.all и функционал
  # модуля InstanceCounter через хэши. Данный модуль поможет зарефакторить и Interface.
  # Я вероятно сделаю это завтра, и обновленная версия будет в следующем коммите.
  # Пока сдаю на проверку всё то что требовалось в задании.
  @count = 0
  @@trains = {}

  def self.find(id)
    @@trains[id]
  end

  def initialize(id, type)
      @type = type
      @id = id
      @wagons = []
      @speed = 0
      @route = nil
      @current_station = nil
      register_instance
      @@trains[id] = self
  end

  def add_wagon(wagon)
    self.wagons << wagon if (self.type == wagon.type && speed == 0)
  end

  def remove_wagon(wagon)
    self.wagons.delete(wagon) if (self.type == wagon.type && speed == 0)
  end

  def to_s
    puts "Number: #{ self.id }, Type; #{self.type} "
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

  attr_writer :id, :type, :speed, :wagons, :current_station, :route

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
