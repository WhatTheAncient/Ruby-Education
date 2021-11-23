class Interface

  def initialize
    @end_of_program = false
    @user_choice = nil
    @trains = {}
    @stations = {}
    @routes = {}
  end

  def start
    until self.end_of_program
      show_menu
      puts "Choose what you want to do: "
      user_choice = gets.to_i
      case user_choice
      when 0 then create_station
      when 1 then create_train
      when 2 then create_route
      when 3 then manage_route
      when 4 then set_route
      when 5 then add_wagon
      when 6 then remove_wagon
      when 7 then move_train
      when 8 then show_stations
      when 9 then show_trains
      else end_of_program = true
      end
    end
  end

  private

  attr_accessor :end_of_program, :trains, :stations, :routes, :user_choice

  MENU = {
    0 => "Create station.",
    1 => "Create train.",
    2 => "Create route.",
    3 => "Manage route.",
    4 => "Set route to train.",
    5 => "Add wagon to train.",
    6 => "Remove wagon from train.",
    7 => "Move train between stations.",
    8 => "Show stations on route.",
    9 => "Show trains on station",
    "Another button" => "Exit"
  }

  ROUTE_MANAGEMENT = {
    0 => "Add station.",
    1 => "Remove station."
  }

  TRAIN_MOVEMENTS = {
    0 => "Move forward",
    1 => "Move backward"
  }

  def show_menu
    MENU.each { |item| puts "#{item[0]} - #{item[1]}" }
  end

  def show_route_management
    ROUTE_MANAGEMENT.each { |item| puts "#{item[0]} - #{item[1]}" }
  end

  def show_train_movements
    TRAIN_MOVEMENTS.each {|move| puts "#{move[0]} - #{move[1]}"}
  end

  def create_station
    puts "Enter station name"
    station_name = gets.chomp
    self.stations[station_name] = Station.new(station_name)
  end

  def create_train
    puts "Enter train id and type"
    train_id = gets.chomp
    train_type = gets.chomp
    attempt = 0
    case train_type.downcase!
    when 'cargo' then self.trains[train_id] = CargoTrain.new(train_id)
    when 'passenger' then self.trains[train_id] = PassengerTrain(train_id)
    else
      self.trains[train_id] = Train.new(train_id, train_type)
    end
    puts "Created #{train_type} train with id = #{train_id}" if self.trains[train_id].valid?
    rescue RuntimeError => e
      attempt += 1
      puts "#{e.message}"
      retry if attempt <= 1
  end

  def create_route
    puts "Enter the name of route and it start and finish"
    route_name = gets.chomp
    start = gets.chomp
    finish = gets.chomp
    first_station = Station.new(start)
    last_station = Station.new(finish)
    self.stations[start], self.stations[finish] = first_station, last_station
    self.routes[route_name] = Route.new(first_station, last_station)
  end

  def manage_route
    show_route_management
    puts "Enter route name and your choice"
    route_name = gets.chomp
    choice = gets.to_i
    case choice
    when 0
      puts "Enter the station name"
      station_name = gets.chomp
      self.routes[route_name].add_station(stations[station_name])
    when 1
      puts "Enter the station name"
      station_name = gets.chomp
      self.routes[route_name].remove_station(stations[station_name])
    end
  end

  def set_route
    puts "Enter the train id"
    train_id = gets.chomp
    puts "Enter the route name"
    route_name = gets.chomp
    self.trains[train_id].set_route(self.routes[route_name])
  end

  def add_wagon
    puts "Enter the wagon id and type"
    wagon_id = gets.chomp
    wagon_type = gets.chomp
    puts "Enter the train id"
    train_id = gets.chomp
    case wagon_type.downcase!
    when 'cargo' then self.trains[train_id].add_wagon(CargoWagon.new(wagon_id))
    when 'passenger' then self.trains[train_id].add_wagon(PassengerWagon.new(wagon_id))
    else
      self.trains[train_id].add_wagon(Wagon.new(wagon_id, wagon_type))
    end
  end

  def remove_wagon
    puts "Enter the wagon id and type"
    wagon_id = gets.chomp
    wagon_type = gets.chomp
    puts "Enter the train id"
    train_id = gets.chomp
    case wagon_type.downcase!
    when 'cargo' then self.trains[train_id].remove_wagon(CargoWagon.new(wagon_id))
    when 'passenger' then self.trains[train_id].remove_wagon(PassengerWagon.new(wagon_id))
    else
      self.trains[train_id].add_wagon(Wagon.new(wagon_id, wagon_type))
    end
  end

  def move_train
    show_train_movements
    puts "Enter the train id and your choice"
    train_id = gets.chomp
    choice = gets.to_i
    case choice
    when 0 then self.trains[train_id].move_fd
    when 1 then self.trains[train_id].move_back
    end
  end

  def show_stations
    puts "Enter the route name"
    route_name = gets.chomp
    puts self.routes[route_name].stations
  end

  def show_trains
    puts "Enter the station name"
    station_name = gets.chomp
    puts self.stations[station_name].trains
  end

end