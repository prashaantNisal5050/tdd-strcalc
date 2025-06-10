class StringCalculator
  def initialize(input)
    @input = input.strip
  end

  def add
    return 0 if @input.empty?
    return @input.to_i if @input =~ /^-?\d+$/
  end
end