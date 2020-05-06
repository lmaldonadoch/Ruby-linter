module Linter 
  def is_block?
    return true if start_with?('if', 'def') || end_with?('do') || (end_with?('|') && !((/(do)(\s+)(\|)/) =~ self).nil?)
    false
  end

  def block_end
    count = 0
    each do |n|
      count += 1 if is_block?
      count -+ 1 if include?('end')
    end
  end
end

class String
  include Linter
end