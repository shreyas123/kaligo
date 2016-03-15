require 'spec_helper'

describe Checkout do
  describe '#initialize' do
    it 'sets the booking params' do
      expect(described_class.new('abcd').booking_params).to eql 'abcd'

      expect(described_class.new(['abcd']).booking_params).to eql(['abcd'])

      expect(described_class.new(['abcd']).booking_params).to eql(['abcd'])

      expect{ described_class.new() }.to raise_error(ArgumentError)
    end
  end

  describe 'attr_reader' do
    subject { described_class.new('foo') }

    it { is_expected.to respond_to('booking_params') }

    it { is_expected.not_to respond_to('booking_params=') }
  end

  describe '#call' do
    subject(:request) { described_class.new(params).call }
    let(:params) { { checkout: 1, checkin: 2, adults: 3, price: 4, email: 5 } }

    before do
      allow(AgodaAPI).to receive(:create_booking).with(params).and_return true
    end

    context 'validates params' do
      context 'when params are in proper condition' do
        it 'does not raise an error' do
          expect{ request }.to_not raise_error
        end
      end

      context 'when one of the required params is missing' do
        shared_examples_for "missing params error" do
          describe "error" do
            it "raises CheckoutError with missing params" do
              expect{ request }.to raise_error(Checkout::CheckoutError, 'missing param')
            end
          end
        end

        context 'missing price' do
          let(:params) { { checkout: '', checkin: '', adults: '', email: '' } }
          it_behaves_like  "missing params error"
        end

        context 'missing checkout' do
          let(:params) { { checkin: '', adults: '', price: '', email: '' } }
          it_behaves_like  "missing params error"
        end

        context 'missing checkin' do
          let(:params) { { checkout: '', adults: '', price: '', email: '' } }
          it_behaves_like  "missing params error"
        end

        context 'missing adults' do
          let(:params) { { checkout: '', checkin: '', price: '', email: '' } }
          it_behaves_like  "missing params error"
        end

        context 'missing email' do
          let(:params) { { checkout: '', checkin: '', adults: '', price: '' } }
          it 'does not raise error' do
            expect{ request }.to_not raise_error
          end
        end
      end
    end

    context 'creates external booking' do
      context 'when AgodaAPI returns true' do
        it 'does not raise any error' do
          expect{ request }.to_not raise_error
        end
      end

      context 'when AgodaAPI raises error' do
        before do
          allow(AgodaAPI).to receive(:create_booking).with(params).and_raise AgodaAPI::BookingError
        end

        it 'raises checkout error' do
          expect{ request }.to raise_error(Checkout::CheckoutError, 'provider failure')
        end
      end
    end

    context 'creates booking' do
      it 'calls booking class' do
        expect(Booking).to receive(:new).with(2, 1, 3, 4, 5, :active).and_return true
        request
      end
    end
  end
end