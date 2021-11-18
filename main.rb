require_relative 'classes/route.rb'
require_relative 'classes/station.rb'
require_relative 'classes/train'

station_1 = Station.new('station')
station_2 = Station.new('station_2')
route = Route.new(station_1, station_2)
train = Train.new('1', 'cargo')

train.set_route(route)

puts train.current_station
train.move_back
puts train.current_station
train.move_fd
puts train.current_station
train.move_fd
puts train.current_station