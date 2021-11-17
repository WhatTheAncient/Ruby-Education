class Train
  attr_accessor :speed, :wagons, :current_station, :route
  attr_reader :id, :type

  def initialize(id, type)
    if type == 'cargo' || type == 'passenger'
      @type = type
      @id = id
      @wagons = 0
      @speed = 0
      @route = nil
      @current_station = Station.new('Depot')
    else
      puts "Train can be only passenger or cargo."
    end
  end

  def stop
    self.speed = 0
  end

  def add_wagon
      self.wagons += 1 if speed == 0
  end

  def remove_wagon
    if wagons > 0
      self.wagons -= 1 if speed == 0
    end
  end

  def to_s
    puts "Number: #{ self.id }, Type; #{self.type} "
  end

  def set_route(route)
    raise TypeError unless route.is_a? Route
    self.route = route
    self.current_station = route.stations.first
  end

  def move_fd
    unless self.current_station.name == route.stations.last
    self.current_station = self.route.stations[self.route.stations.find_index(self.current_station) + 1]
    end
  end

  def move_back
    unless self.current_station.name == route.stations.first
    self.current_station = self.route.stations[self.route.stations.find_index(self.current_station) - 1]
    end
  end
end
