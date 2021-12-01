class PassengerWagon < Wagon

  def initialize(id, type=:passenger, seats)
    super(id, type)
    @seats = {} #Я использовал хэш так как с помощью него можно занять какое-то конкретное место
    seats.times {|seat| @seats[seat + 1] = 0}
  end

  def seats
    @seats.size #Если использовать self.seats то ловится SystemStackError
  end

  def take_seat(number)
    @seats[number] = 1 if number <= @seats.size && @seats[number] != 1
  end

  def taken_seats
    @seats.values.select {|seat| seat == 1}.count
  end

  def free_seats
    seats - taken_seats
  end

  def to_s
    super + " Count of free seats: #{free_seats}, count of taken seats: #{taken_seats}."
  end
  private
  attr_writer :seats
end