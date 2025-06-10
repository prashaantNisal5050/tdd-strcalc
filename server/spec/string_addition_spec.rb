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
    it 'returns sum of all numbers if input contains comma separated numbers' do
      expect(StringCalculator.new("1, 2, 3, 4, 5").add).to eq(15)
    end
    it 'returns sum of two numbers if input contains new line in between two numbers' do
      expect(StringCalculator.new("1\n2").add).to eq(3)
      expect(StringCalculator.new("\n2,1").add).to eq(3)
      expect(StringCalculator.new("1,2\n").add).to eq(3)
      expect(StringCalculator.new("1\n,2,3\n4,5").add).to eq(15)
    end
    
    it 'ignores numbers bigger than 1000' do 
      expect(StringCalculator.new("2,1002").add).to eq(2)
    end
  end
end
