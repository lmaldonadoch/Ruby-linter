require_relative 'linter.rb'

class LinterClass
  include Linter

  attr_reader :block_dictionary, :missing_parenthesis
  attr_accessor :line_length, :block_length, :class_length, :indentation
  
  def initialize(arr, line_length, block_length, class_length, indentation)
    @arr = arr
    @line_length = line_length
    @block_length = block_length
    @class_length = class_length
    @indentation = indentation
    @block_dictionary = []
    @missing_parenthesis = []
    @line_length_errors = []
    @arr.each_with_index do |n, i|
      block_dictionary_creator(@block_dictionary, n, i)
      parenthesis(@missing_parenthesis, n, i)
      line_length_validate()
    end
  end

  def block_dictionary_creator(ret_arr, n, i)
    if n.block?
      ret_arr << [i + 1, (n.length - n.lstrip.length) / 2]
    elsif n.include?('end')
      ret_arr.reverse.each do |m|
        if m.length == 2 && ((n.length - n.lstrip.length) / 2) == m[1]
          m << (i+1)
          break
        end
      end
    end
    ret_arr
  end

  def parenthesis(ret_arr, n, i)
    unless parenthesis_even(n).nil? ret_arr << "Line #{i+1} seems to have more #{parenthesis_even(n)[0]} than #{parenthesis_even(n)[0]}"
      ret_arr << [i + 1, 'parenthesis']
    elsif n.count('{') != n.count('}')
    ret_arr << [i + 1, 'curly brackets'] 
    elsif n.count('[') != n.count(']')
      ret_arr << [i + 1, 'brackets']
    end
  end

  def variable_out_of_scope(n)
    if n.include?(' = ') || (n.lstrip.start_with?('def') && n.end_with?(')'))
    end

  end

  def line_length_validate (ret_arr, n, i)
      ret_arr << ["Line #{i+1} does not satisfy the maximum line length given of #{@line_length}"] if n.length >= @line_length
  end


end
