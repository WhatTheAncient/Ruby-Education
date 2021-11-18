class Route

  attr_accessor :stations

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
