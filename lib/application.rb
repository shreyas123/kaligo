class Application
  attr_reader :bookings

  def initialize
    @bookings = []
  end

  def create_booking(booking_params)
    booking = Checkout.new(booking_params).()
    @bookings << booking
    booking
  rescue Checkout::CheckoutError
    false
  end

end
