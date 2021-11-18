class Train

  attr_accessor :speed, :wagons, :current_station, :route
  attr_reader :id, :type

  def initialize(id, type)
      @type = type
      @id = id
      @wagons = 0
      @speed = 0
      @route = nil
      @current_station = nil
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
    self.route = route
    self.current_station = route.stations.first
    self.current_station.take_train(self)
  end

  def move_fd
    self.current_station = next_station if next_station
  end

  def move_back
    self.current_station = previous_station if previous_station
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

end
