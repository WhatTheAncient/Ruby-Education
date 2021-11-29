
class CargoWagon < Wagon
  attr_reader :filled_volume
  strong_attr_accessor :volume, Fixnum
  def initialize(id, type=:cargo, volume)
    super(id, type)
    @volume = volume
    @filled_volume = 0
  end

  def fill(volume)
    if volume <= free_volume
      self.filled_volume += volume
    end
  end

  def free_volume
    self.volume - self.filled_volume
  end

  def to_s
    super + " Free volume: #{free_volume}, filled volume: #{self.filled_volume}."
  end

  private
  attr_writer :filled_volume
end