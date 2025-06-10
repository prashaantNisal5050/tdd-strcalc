class StringCalculator
  def initialize(input)
    @input = input.strip.gsub("\\n", "\n")
  end

  def add
    return 0 if @input.empty?

    if @input.start_with?("//")
      delimiter_line, numbers_part = @input.split("\n", 2)
      delimiter = delimiter_line[2..]

      # Check for any characters other than digits, delimiter, or minus sign
      valid_pattern = Regexp.escape(delimiter)
      unless numbers_part.scan(/[^0-9\-#{valid_pattern}]/).empty?
        raise "Invalid delimiter used in input. Only allowed delimiters: #{delimiter}"
      end

      parts = numbers_part.split(delimiter)
    else
      parts = @input.gsub("\n", ',').split(',')
    end

    numbers = parts.map(&:strip)
                   .reject(&:empty?)
                   .map(&:to_i)

    negatives = numbers.select { |n| n < 0 }
    raise "Negatives not allowed: #{negatives.join(', ')}" if negatives.any?

    numbers.reject { |n| n > 1000 }.sum
  end
end
