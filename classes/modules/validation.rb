module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  module ClassMethods
    def validate(object, type, *args)
      case type.to_sym
      when :presence
        raise "Presence validation failed" if object.nil? or object == ''
      when :format
        raise "Format validation failed" unless object !~ args
      when :type
        raise "Type validation failed" unless object.is_a? args[0]
      end
    end
  end
  module InstanceMethods
    def valid?(format, type)
      validate!(format, type)
      true
    rescue
      false
    end
    def validate!(format, type)
      self.class.validate(self, :presence)
      self.class.validate(self, :format, format)
      self.class.validate(self, :type, type)
    end
  end
end