require_relative '../add'
require 'byebug'
require 'rspec'

RSpec.describe StringCalculator do
  describe '#add' do
    it 'returns 0 for empty' do
      expect(StringCalculator.new("").add).to eq(0)
    end
  end
end
