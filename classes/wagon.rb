require_relative 'modules/manufacturer'
require_relative 'modules/validation_check'
class Wagon
  include ValidationCheck
  include Manufacturer
  attr_accessor :id, :type

  def initialize(id, type)
    @id = id
    @type = type
    validate!
  end

  def to_s
    "id: #{self.id}, type: #{self.type}."
  end

  protected
  TYPE_FORMAT = /^[a-z]+$/i
  ID_FORMAT = /^\d+$/
  def validate!
    raise "Wagon id can't contain symbols!" if self.id !~ ID_FORMAT
    raise "Wagon type can only contain latin symbols!" if self.type !~ TYPE_FORMAT
  end
end