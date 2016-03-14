class AgodaAPI
  BookingError = Class.new(RuntimeError)

  def self.create_booking(booking_params)
    [ -> { true }, -> { raise BookingError, "booking failed" } ].sample.call
  end
end
