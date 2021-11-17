class Route
  attr_accessor :stations
  attr_reader :start, :finish

  def initialize(start, finish)
    raise TypeError unless (start.is_a?(String) && finish.is_a?(String))
    @stations = []
    @stations << start
    @stations << finish
  end

  def add_station(station)
    raise TypeError unless station.is_a? String
    stations.insert(stations.size - 1, station) unless stations.include? station
  end

  def remove_station(station)
    raise TypeError unless station.is_a? String
    stations.delete(station) if stations.include? station
  end
end
