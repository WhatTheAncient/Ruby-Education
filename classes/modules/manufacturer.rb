
module Manufacturer

  def manufacturer=(name)
    self.name = name
  end

  def manufacturer
    self.name
  end

  protected

  attr_accessor :name

end