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
  -1 => "Exit"
}

route_management = {
  0 => "Add station.",
  1 => "Remove station."
}

trains = []
stations = Hash.new
routes = Hash.new

until end_of_program
  menu.each {|item| puts "#{item[0]} - #{item[1]}"}

  user_choice = gets.to_i

  case user_choice
  when 0
    puts "Enter station name"
    station_name = gets
    stations[station_name] = Station.new(station_name)
  when 1
    puts "Enter train id and type"
    id = gets
    type = gets
    case type.downcase
    when 'cargo' then trains << CargoTrain.new(id)
    when 'passenger' then trains << PassengerTrain.new(id)
    else
      trains << Train.new(id, type)
    end
  when 2
    puts "Enter the name of route and it start and finish"
    route_name = gets
    start = gets
    finish = gets
    routes[route_name] = Route.new(stations[start], stations[finish])
  when 3
    route_management.each {|move| puts "#{move[0]} - #{move[1]}"}
    puts "Enter route name and your choice"
    route_name = gets
    choice = gets.to_i
    case choice
    when 0
      puts "Enter the station name"
      station_name = gets
      routes[route_name].add_station(stations[station_name])
    when 1
      puts "Enter the station name"
      station_name = gets
      routes[route_name].remove_station(stations[station_name])
    end

  end

end

#cargo = CargoWagon.new(1)

#puts cargo.type

#cargo_train = CargoTrain.new(1)

#cargo_train.add_wagon(cargo)
#puts cargo_train.wagons