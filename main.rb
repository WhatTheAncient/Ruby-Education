require_relative 'classes/train'
require_relative 'classes/route'
require_relative 'classes/station'
require_relative 'classes/wagon'
require_relative 'classes/cargo_train'
require_relative 'classes/cargo_wagon'
require_relative 'classes/passenger_train'
require_relative 'classes/passenger_wagon'

end_of_program = false
menu = {
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

route_management = {
  0 => "Add station.",
  1 => "Remove station."
}

train_movement = {
  0 => "Move forward",
  1 => "Move backward"
}

trains = Hash.new
stations = Hash.new
routes = Hash.new

until end_of_program
  menu.each {|item| puts "#{item[0]} - #{item[1]}"}

  user_choice = gets.to_i

  case user_choice
  when 0
    puts "Enter station name"
    station_name = gets.chomp
    stations[station_name] = Station.new(station_name)
  when 1
    puts "Enter train id and type"
    train_id = gets.chomp
    train_type = gets.chomp
    case train_type.downcase!
    when 'cargo' then trains[train_id] = CargoTrain.new(train_id)
    when 'passenger' then trains[train_id] = PassengerTrain(train_id)
    else
      trains[train_id] = Train.new(train_id, train_type)
    end
  when 2
    puts "Enter the name of route and it start and finish"
    route_name = gets.chomp
    start = gets.chomp
    finish = gets.chomp
    first_station = Station.new(start)
    last_station = Station.new(finish)
    stations[start], stations[finish] = first_station, last_station
    routes[route_name] = Route.new(first_station, last_station)
  when 3
    route_management.each {|move| puts "#{move[0]} - #{move[1]}"}
    puts "Enter route name and your choice"
    route_name = gets.chomp
    choice = gets.chomp.to_i
    case choice
    when 0
      puts "Enter the station name"
      station_name = gets.chomp
      routes[route_name].add_station(stations[station_name])
    when 1
      puts "Enter the station name"
      station_name = gets.chomp
      routes[route_name].remove_station(stations[station_name])

    end
  when 4
    puts "Enter the train id"
    train_id = gets.chomp
    puts "Enter the route name"
    route_name = gets.chomp
    trains[train_id].set_route(routes[route_name])
  when 5
    puts "Enter the wagon id and type"
    wagon_id = gets.chomp
    wagon_type = gets.chomp
    puts "Enter the train id"
    train_id = gets.chomp
    case wagon_type.downcase!
    when 'cargo' then trains[train_id].add_wagon(CargoWagon.new(wagon_id))
    when 'passenger' then trains[train_id].add_wagon(PassengerWagon.new(wagon_id))
    else
      trains[train_id].add_wagon(Wagon.new(wagon_id, wagon_type))
    end
  when 6
    puts "Enter the wagon id and type"
    wagon_id = gets.chomp
    wagon_type = gets.chomp
    puts "Enter the train id"
    train_id = gets.chomp
    case wagon_type.downcase!
    when 'cargo' then trains[train_id].remove_wagon(CargoWagon.new(wagon_id))
    when 'passenger' then trains[train_id].remove_wagon(PassengerWagon.new(wagon_id))
    else
      trains[train_id].add_wagon(Wagon.new(wagon_id, wagon_type))
    end
  when 7
    train_movement.each {|move| puts "#{move[0]} - #{move[1]}"}
    puts "Enter the train id and your choice"
    train_id = gets.chomp
    choice = gets.chomp.to_i
    case choice
    when 0 then trains[train_id].move_fd
    when 1 then trains[train_id].move_back
    end
  when 8
    puts "Enter the route name"
    route_name = gets.chomp
    puts routes[route_name].stations
  when 9
    puts "Enter the station name"
    station_name = gets.chomp
    puts stations[station_name].trains
  else end_of_program = true
  end

end
