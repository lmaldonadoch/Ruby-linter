module Linter
  def block?
    return true if lstrip.start_with?('if', 'def', 'while', 'until') || end_with?('do') || (end_with?('|') && !(/(do)(\s+)(\|)/ =~ self).nil?)

    false
  end

  def parenthesis_even (n)
    return ['(', ')'] if n.count('(') < n.count(')')
    return [')', '('] if n.count('(') > n.count(')')
  end

  def brackets_even (n)
    return ['[', ']'] if n.count('[') < n.count(']')
    return [']', '['] if n.count('[') > n.count(']')
  end

  def curly_brackets_even (n)
    return ['{', '}'] if n.count('{') < n.count('}')
    return ['}', '{'] if n.count('{') > n.count('}')
  end
end

class String
  include Linter
end
