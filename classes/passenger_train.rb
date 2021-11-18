class PassengerTrain < Train

  def initialize(id, type=:cargo)
    super
  end

  def add_wagon(wagon)
    super if wagon.is_a? PassengerWagon
  end
end