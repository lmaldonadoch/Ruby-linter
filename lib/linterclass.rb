# rubocop:disable Layout/LineLength
require_relative 'linter.rb'

class LinterClass
  include Linter

  attr_reader :line_indentation_errors, :arr, :block_dictionary, :missing_parenthesis, :line_length_errors, :block_errors, :trailing_space_errors, :multiple_empty_lines_errors, :logic_operators_errors

  def initialize(arr, line_length, block_length, class_length, indentation)
    @arr = arr
    @line_length = line_length
    @block_length = block_length
    @class_length = class_length
    @indentation = indentation
    @block_dictionary = []
    @missing_parenthesis = []
    @line_length_errors = []
    @block_errors = []
    @trailing_space_errors = []
    @multiple_empty_lines_errors = []
    @logic_operators_errors = []
    @line_indentation_errors = []
    check_indentation
  end

  def validate
    @arr.each_with_index do |n, i|
      block_dictionary_creator(@block_dictionary, n, i)
      parenthesis(@missing_parenthesis, n, i)
      line_length_validate(@line_length_errors, n, i)
      trailing_space_validate(@trailing_space_errors, n, i)
      multiple_empty_lines_validate(@multiple_empty_lines_errors, n, i)
      logic_operators_validate(@logic_operators_errors, n, i)
    end
    block_length
  end

  def block_dictionary_creator(ret_arr, line, index)
    if line.block?
      ret_arr << [index + 1, (line.length - line.lstrip.length) / @indentation]
    elsif line.include?('end')
      ret_arr.reverse.each do |m|
        if m.length == 2 && ((line.length - line.lstrip.length) / @indentation) == m[1]
          m << (index + 1)
          break
        end
      end
    end
    ret_arr
  end

  def variable_out_of_scope(line)
    if line.include?(' = ') || (line.lstrip.start_with?('def') && line.end_with?(')'))
    end
  end

  def line_length_validate(ret_arr, line, index)
    ret_arr << ["Line #{index + 1} does not satisfy the maximum line length given of #{@line_length}"] if line.length >= @line_length
  end

  def trailing_space_validate(ret_arr, line, index)
    ret_arr << ["Line #{index + 1} ends with trailing space"] if line.end_with?(' ')
  end

  def multiple_empty_lines_validate(ret_arr, line, index)
    ret_arr << ["Line #{index + 1} is preceded by another empty line"] if line == '' && @arr[index - 1] == ''
  end

  def logic_operators_validate(ret_arr, line, index)
    ret_arr << ["Line #{index + 1} is performing a logic operation using 'and', consider using '&&' instead"] if line.include?(' and ')
    ret_arr << ["Line #{index + 1} is performing a logic operation using 'or', consider using '||' instead"] if line.include?(' or ')
  end

  def parenthesis(ret_arr, line, index)
    ret_arr << "Line #{index + 1} seem to have more '#{parenthesis_even(line)[1]}' than '#{parenthesis_even(line)[0]}'" unless parenthesis_even(line).nil?
    ret_arr << "Line #{index + 1} seem to have more '#{brackets_even(line)[1]}' than '#{brackets_even(line)[0]}'" unless brackets_even(line).nil?
    ret_arr << "Line #{index + 1} seem to have more '#{curly_brackets_even(line)[1]}' than '#{curly_brackets_even(line)[0]}'" unless curly_brackets_even(line).nil?
  end

  def block_length
    @block_dictionary.each do |block|
      if @arr[block[0] - 1].start_with?('class') && block[2] - block[0] > @class_length
        @block_errors << "Block starting at #{block[0]} does not satisfy the maximum class length given of #{@class_length}"
      elsif block[2] - block[0] > @block_length
        @block_errors << "Block starting at #{block[0]} does not satisfy the maximum block length given of #{@class_length}"
      end
    end
  end

  def check_indentation
    count = 0
    @arr.each_with_index do |line, index|
      @line_indentation_errors << "Line #{index + 1} should have #{count * @indentation} spaces" unless (line.start_with?(' ' * (count * @indentation)) || line.strip == '' || (line.strip == 'end' && line.start_with?(' ' * [0, (count-1)].max * @indentation)))
      count += 1 if line.block?
      count -= 1 if line.strip == 'end'
    end
  end

  def indentation_autocorrect
    count = 0
    @arr.each_with_index do |line, index|
      if line.strip == 'end'
        (@arr[index] = (' ' * ([0, (count-1)].max * @indentation)) + line.lstrip)
      elsif line.strip == ''
        @arr[index] = ''
      else
        (@arr[index] = (' ' * (count * @indentation)) + line.lstrip) if (line != '' || line.strip != 'end')
      end
      count += 1 if line.block?
      count -= 1 if line.strip == 'end'
    end
  end
end
# rubocop:enable Layout/LineLength
