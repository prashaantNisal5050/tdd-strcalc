class StringCalculator
  def initialize(input)
    @input = input.strip
    @custom_delimiters = []
  end

  def add
    return 0 if @input.empty?

    normalize_newlines

    if @input.start_with?("//")
      delimiter_section, number_section = @input.split("\n", 2)
      extract_custom_delimiters(delimiter_section)
      sections = split_by_delimiters(number_section, @custom_delimiters)
      numbers = extract_numbers(sections, @custom_delimiters)
    else
      sections = @input.split(/,|\n/)
      numbers = extract_numbers(sections) # no strict validation needed
    end

    validate_negatives(numbers)
    numbers.sum
  end

  private

  def normalize_newlines
    @input = @input.gsub("\\n", "\n")
  end

  def extract_custom_delimiters(section)
    if section.include?("[")
      @custom_delimiters = section.scan(/\[(.*?)\]/).flatten
    else
      @custom_delimiters = [section[2..]]
    end
  end

  def split_by_delimiters(input, delimiters)
    delimiters.reduce([input]) do |parts, delim|
      parts.flat_map { |s| s.split(delim) }
    end
  end

  def extract_numbers(sections, allowed_delimiters = nil)
    if allowed_delimiters && !allowed_delimiters.empty?
      joined = sections.join
      allowed_pattern = /\A[-\d#{Regexp.escape(allowed_delimiters.join)}]+\z/
      unless joined.match?(allowed_pattern)
        raise "Invalid delimiter used in input. Only allowed delimiters: #{allowed_delimiters.join(', ')}"
      end
    end

    sections.flat_map { |s| s.scan(/-?\d+/) }
            .map(&:to_i)
            .reject { |n| n > 1000 }
  end

  def validate_negatives(numbers)
    negatives = numbers.select { |n| n < 0 }
    raise "Negatives not allowed: #{negatives.join(', ')}" if negatives.any?
  end
end