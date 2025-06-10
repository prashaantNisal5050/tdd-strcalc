require_relative '../add'
require 'byebug'
require 'rspec'

RSpec.describe StringCalculator do
  describe '#add' do
    it 'returns 0 for empty' do
      expect(StringCalculator.new("").add).to eq(0)
    end

    it 'returns a number itself if input contains a single number' do
      expect(StringCalculator.new("1").add).to eq(1)
    end
    it 'returns sum of two numbers if input contains two comma separated numbers' do
      expect(StringCalculator.new("1, 2").add).to eq(3)
    end
  end
end
