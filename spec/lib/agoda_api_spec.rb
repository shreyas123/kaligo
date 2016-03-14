require 'spec_helper'
require_relative '../../lib/agoda_api'

describe AgodaAPI do
  describe '.create_booking' do
    subject(:request) { described_class.create_booking({}) }

    before do
      class Array
        def sample
          return self[0]
        end
      end
    end

    context 'when first object returned' do
      it 'returns true' do
        expect( request ).to be_truthy
      end
    end

    context 'when Array returns 2nd object' do
      before do
        class Array
          def sample
            return self[1]
          end
        end
      end
      it 'returns true' do
        expect{ request }.to raise_error(AgodaAPI::BookingError, 'booking failed')
      end
    end
  end
end
