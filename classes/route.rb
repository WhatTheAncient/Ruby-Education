class Route
  attr_accessor :stations

  def initialize(start, finish)
    raise TypeError unless (start.is_a?(Station) && finish.is_a?(Station))
    @stations = []
    @stations << start
    @stations << finish
  end

  def add_station(station)
    raise TypeError unless station.is_a? Station
    self.stations.insert(stations.size - 1, station) unless self.stations.include? station
  end

  def remove_station(station)
    raise TypeError unless station.is_a? Station
    self.stations.delete(station) if self.stations.include? station
  end
end
