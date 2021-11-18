class Wagon
  attr_accessor :id, :type

  def initialize(id, type)
    @id = id
    @type = type
  end

  def to_s
    puts self.id
  end
end