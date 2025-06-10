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
    it 'throws an exception if multiple negative numbers are included' do
      expect { StringCalculator.new("1,-2,3,-4").add }.to raise_error(RuntimeError, "Negatives not allowed: -2, -4")
    end
    it 'throws an exception if negative numbers are in custom delimiter format' do
      expect { StringCalculator.new("//;\\n1;2;-3;4").add }.to raise_error(RuntimeError)
    end
    it 'allows input with custom delimiter' do
      expect(StringCalculator.new("//;\\n1;2").add).to eq(3)
    end
    it 'allows input with custom delimiter and ignores non-matching tokens' do
      expect {StringCalculator.new("//;\\n1XY;2_+3(4)$5").add}.to raise_error("Invalid delimiter used in input. Only allowed delimiters: ;")
    end
    it 'allows multiple delimiters with longer length' do
      expect(StringCalculator.new("//[****]\\n1****2****3").add).to eq(6) 
    end
    it 'allows multiple delimiters' do
      expect(StringCalculator.new("//[*][%]\n1*2%3").add).to eq(6) 
    end
  end
end
