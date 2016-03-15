require 'spec_helper'

describe Booking do
  describe '#initialize' do
    shared_examples_for "respond_to" do |attr|
      describe "certain attibutes" do
        it { is_expected.to respond_to(:"#{attr}") }
        it { is_expected.to respond_to(:"#{attr}=") }
      end
    end

    subject { described_class.new }

    it_should_behave_like 'respond_to', :checkin
    it_should_behave_like 'respond_to', :checkout
    it_should_behave_like 'respond_to', :adults
    it_should_behave_like 'respond_to', :price
    it_should_behave_like 'respond_to', :status


    context 'values check' do
      it 'responds to certain paarams passed to it' do
        booking = Booking.new(10, 20, 30, 40, 50, 60)
        expect(booking.checkin).to eql 10
        expect(booking.checkout).to eql 20
        expect(booking.adults).to eql 30
        expect(booking.price).to eql 40
        expect(booking.email).to eql 50
        expect(booking.status).to eql 60
      end
    end
  end
end
