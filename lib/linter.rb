module Linter
  def block?
    if strip.start_with?('if', 'def', 'while', 'until') || strip.end_with?('do') || (strip.end_with?('|') && !(/(do)(\s+)(\|)/ =~ self).nil?)
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
end

class String
  include Linter
end
