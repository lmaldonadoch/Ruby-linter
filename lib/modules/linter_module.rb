module Linter
  def block?
    if strip.start_with?('if', 'def', 'while', 'until', 'module', 'unless') || strip.end_with?('do') ||
       (strip.end_with?('|') && !(/(do)(\s+)(\|)/ =~ self).nil?)
      return true
    end

    false
  end

  def parenthesis_even(line)
    return ['(', ')'] if line.count('(') < line.count(')')
    return [')', '('] if line.count('(') > line.count(')')
  end

  def brackets_even(line)
    return ['[', ']'] if line.count('[') < line.count(']')
    return [']', '['] if line.count('[') > line.count(']')
  end

  def curly_brackets_even(line)
    return ['{', '}'] if line.count('{') < line.count('}')
    return ['}', '{'] if line.count('{') > line.count('}')
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/BlockNesting

  def operator_validator(line)
    operators = ['+', '-', '>', '<', '!', '*', '=']
    ret_arr = []
    operators.each do |n|
      arr = line.chars
      counter = 0
      while counter < arr.length
        if arr[counter] == n
          if operators.include?(arr[counter - 1]) && n == '='
            counter += 1
            next
          end
          dummy_arr = []
          if arr[counter + 1] == '='
            dummy_arr << (arr[counter] + '=')
            dummy_arr << (arr[counter - 1] == ' ' ? -1 : counter - 1)
            dummy_arr << (arr[counter + 2] == ' ' ? -1 : counter + 2)
            counter += 2
          else
            dummy_arr << (arr[counter])
            dummy_arr << (arr[counter - 1] == ' ' ? -1 : counter - 1)
            dummy_arr << (arr[counter + 1] == ' ' ? -1 : counter + 1)
            counter += 1
          end
          ret_arr << dummy_arr
        else
          counter += 1
        end
      end
    end
    ret_arr
  end

  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/BlockNesting
end

class String
  include Linter
end
