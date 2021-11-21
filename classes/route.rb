#В данном классе все методы и атрибуты должны быть public, так как они используются как в пользовательском
# интерфейсе так и в других классах
require_relative 'modules/instance_counter'
class Route
  include InstanceCounter
  attr_accessor :stations
  @count = 0

  def initialize(start, finish)
    @stations = []
    @stations << start
    @stations << finish
  end

  def add_station(station)
    self.stations.insert(stations.size - 1, station)
  end

  def remove_station(station)
    self.stations.delete(station)
  end
end
