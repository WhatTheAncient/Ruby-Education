class CargoTrain < Train

  def initialize(id, type=:passenger)
    super
  end

  def add_wagon(wagon)
    super if wagon.is_a? CargoWagon
  end

end