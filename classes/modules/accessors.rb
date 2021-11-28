module Accessors
  def attr_accessor_with_history (*attrs)
    attrs.each do |attr|
      attr_history = []
      attr_name = "@#{attr}".to_sym
      define_method(attr) {instance_variable_get(attr_name)}
      define_method("#{attr}=") do |value|
        instance_variable_set(attr_name, value)
        attr_history << value
      end
      define_method("#{attr}_history") {attr_history}
    end
  end
  def strong_attr_accessor (*attrs)
    attrs.each_slice(2) do |attr, type|
      attr_name = "@#{attr}".to_sym
      define_method(attr) {instance_variable_get(attr_name)}
      define_method("#{attr}=") do |value|
        if value.is_a? type
          instance_variable_set(attr_name, value)
        else
          raise TypeError
        end
      end
    end
  end
end
