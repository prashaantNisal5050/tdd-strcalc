class StringCalculator
  def initialize(input)
    @input = input.strip
  end

  def add
    return 0 if @input.empty?

    # Replace newline with comma and split by comma
    numbers = @input.gsub("\n", ',').split(',')
                    .map(&:strip)
                    .reject(&:empty?)
                    .map(&:to_i)

    numbers.sum
  end
end
