require 'spec_helper'

describe Application do
  describe '#initialize' do
    it 'sets the booking params' do
      expect(described_class.new.bookings).to eql([])
    end
  end

  describe 'attr_reader' do
    subject { described_class.new }

    it { is_expected.to respond_to('bookings') }

    it { is_expected.not_to respond_to('bookings=') }
  end

  describe '#create_booking' do
    let(:params) { 'sample' }

    before do
      checkout = double('checkout', call: 1)
      allow(Checkout).to receive(:new).with(params).and_return checkout
    end

    it 'calls Checkout and add it to the bookings' do
      expect(described_class.new.create_booking(params)).to eql 1
    end

    it 'adds to booking instance variable' do
      application = described_class.new
      expect(application.bookings).to eql([])
      application.create_booking(params)
      expect(application.bookings).to eql([1])
    end

    context 'when Checkout raises error' do
      before do
        allow(Checkout).to receive(:new).with(params).and_raise Checkout::CheckoutError
      end

      it 'returne false' do
        expect(described_class.new.create_booking(params)).to eql false
      end

      it 'does not add to bookings' do
        application = described_class.new
        expect(application.bookings).to eql([])
        application.create_booking(params)
        expect(application.bookings).to eql([])
      end
    end
  end
end