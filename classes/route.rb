#В данном классе все методы и атрибуты должны быть public, так как они используются как в пользовательском
# интерфейсе так и в других классах
require_relative 'modules/instance_counter'
require_relative 'modules/validation'
require_relative 'station'
class Route
  include Validation
  include InstanceCounter
  attr_accessor :stations, :start, :finish

  def initialize(start, finish)
    @stations = []
    @start = start
    @finish = finish
    @stations << start << finish
  end
  validate :start, :type, Station
  validate :finish, :type, Station
  def add_station(station)
    self.stations.insert(stations.size - 1, station)
  end

  def remove_station(station)
    self.stations.delete(station)
  end

end
