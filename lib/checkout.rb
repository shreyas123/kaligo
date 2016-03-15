class Checkout
  CheckoutError = Class.new(RuntimeError)
  attr_reader :booking_params

  def initialize(booking_params)
    @booking_params = booking_params
  end

  def call
    validate_booking_params
    create_external_booking
    create_internal_booking
  end

  private
    def validate_booking_params
      unless (required_booking_params - booking_params.keys).empty?
        raise CheckoutError, "missing param"
      end
    end

    def create_external_booking
      AgodaAPI.create_booking(booking_params)
    rescue AgodaAPI::BookingError
      raise CheckoutError, "provider failure"
    end

    def create_internal_booking
      Booking.new(booking_params[:checkin],
                  booking_params[:checkout],
                  booking_params[:adults],
                  booking_params[:price],
                  booking_params[:email],
                  :active
                 )
    end

    def required_booking_params
      %i(checkin checkout adults price)
    end

end
