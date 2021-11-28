module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  module ClassMethods
    attr_accessor :validations
    def validate(object, type, *args)
      @validations ||= []
      @validations << {attr: object, validation_type: type, validation_args: args}
    end
  end
  module InstanceMethods
    def valid?
      validate!
      true
    rescue
      false
    end
    def validate!
      self.class.validations.each do |validation|
        attr = instance_variable_get("@#{validation[:attr]}")
        val_type = validation[:validation_type]
        args = validation[:validation_args][0]
        case val_type
        when :presence then raise "Presence validation failed!" if attr.nil? or attr.empty?
        when :format then raise "Format validation failed!" if attr !~ args
        when :type then raise "Type validation failed!" unless attr.instance_of? args
        end
      end
    end
  end
end