class Train
  attr_accessor :speed, :wagons
  attr_reader :id, :type

  def initialize(id, type)
    @id = id
    if type == 'cargo' || type == 'passenger'
      @type = type
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

end
