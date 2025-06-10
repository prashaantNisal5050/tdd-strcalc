class StringCalculator
  def initialize(input)
    @input = input.strip
  end

  def add
    return 0 if @input.empty?
    return @input.to_i if @input =~ /^-?\d+$/
    numbers = @input.split(',').map(&:strip).map(&:to_i)
    numbers.sum
  end
end