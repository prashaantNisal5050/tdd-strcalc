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
                .map(&:to_i).reject { |n| n > 1000 }

    negatives = numbers.select { |n| n < 0 }
    raise "Negatives not allowed: #{negatives.join(', ')}" if negatives.any?

    numbers.sum
  end
end
