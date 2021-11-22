#В данном классе все методы и атрибуты должны быть public, так как они используются как в пользовательском
# интерфейсе так и в других классах
require_relative 'modules/instance_counter'
require_relative 'modules/validation_check'
class Route
  include ValidationCheck
  include InstanceCounter
  attr_accessor :stations

  def initialize(start, finish)
    @stations = []
    validate!(start, finish)
    stations << start << finish
  end

  def add_station(station)
    self.stations.insert(stations.size - 1, station)
  end

  def remove_station(station)
    self.stations.delete(station)
  end

  private
  #Было принято решение передавать старт и финиш в функцию валидации, так как хранить их как инстанс-переменные
  # бесполезно ведь они нигде больше не используются.
  def validate!(start, finish)
    if not ((start.is_a? Station) && (finish.is_a? Station))
    raise "Start and Finish must be class Station instances!"
    end
    raise "Start and Finish must be different stations!" if start.name == finish.name
  end
end
