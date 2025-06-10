class StringCalculator
  def initialize(input)
    @input = input.strip
  end

  def add
    return 0 if @input.empty?

    numbers = @input
                .gsub("\n", ',')
                .split(',')
                .map(&:strip)
                .reject(&:empty?)
                .map(&:to_i)
                .reject { |n| n > 1000 }

    numbers.sum
  end
end
