#В данном классе все методы и атрибуты должны быть public, так как они используются как в пользовательском
# интерфейсе так и в других классах
require_relative 'modules/instance_counter'
require_relative 'modules/validation'
class Route
  include Validation
  include InstanceCounter
  attr_accessor :stations

  def initialize(start, finish)
    @stations = []
    @stations << start << finish
    self.class.validate @stations.first, :type, Station
    self.class.validate @stations.last, :type, Station
  end

  def add_station(station)
    self.stations.insert(stations.size - 1, station)
  end

  def remove_station(station)
    self.stations.delete(station)
  end

end
