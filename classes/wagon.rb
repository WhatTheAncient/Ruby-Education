require_relative 'modules/manufacturer'
require_relative 'modules/validation'
require_relative 'modules/accessors'
class Wagon
  include Validation
  include Manufacturer
  extend Accessors
  attr_accessor :id, :type
  def initialize(id, type)
    @id = id
    @type = type
  end
  validate :id, :format, :ID_FORMAT
  validate :type, :format, :TYPE_FORMAT

  def to_s
    "id: #{self.id}, type: #{self.type}."
  end

  protected
  TYPE_FORMAT = /^[a-z]+$/i
  ID_FORMAT = /^\d+$/

end