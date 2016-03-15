require 'spec_helper'
require_relative '../../lib/checkout'

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
end