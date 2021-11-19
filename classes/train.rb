class Train

  attr_accessor :speed, :wagons, :current_station, :route
  attr_reader :id, :type

  def initialize(id, type)
      @type = type
      @id = id
      @wagons = []
      @speed = 0
      @route = nil
      @current_station = nil
  end

  def stop
    self.speed = 0
  end

  def add_wagon(wagon)
    self.wagons << wagon
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
    if next_station
      self.current_station.send_train(self)
      self.current_station = next_station
      self.current_station.take_train(self)
    end
  end

  def move_back
    if previous_station
      self.current_station.send_train(self)
      self.current_station = previous_station
      self.current_station.take_train(self)
    end
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
