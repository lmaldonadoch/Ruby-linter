require_relative '../lib/modules/file_validate.rb'
class ErrorHandler
  include FileValidate

  def initialize(*args)
    @errors = args
    @errors_text = ['Icomplete parenthesis errors:',
                    'Line length errors:',
                    'Trailing white space errors:',
                    'Multiple empty lines errors:',
                    'Spacing around operators:',
                    'Block length errors:',
                    'Empty line at end of file:',
                    'Indentation errors:',
                    'Blocks not closed:']
  end

  def file_validations
    file_validate(@errors[0])
  end

  def total_errors
    sum = 0
    @errors.each do |n|
      sum += n.length
    end
    sum
  end

  def print_errors
    error_arr = validate_empty
    ret_arr = []
    error_arr.each do |n|
      ret_arr << @errors_text[n]
      @errors[n].each { |m| ret_arr << m }
      ret_arr << ''
    end
    ret_arr
  end

  private

  def validate_empty
    ret_arr = []
    @errors.each_with_index do |n, i|
      ret_arr << i unless n.nil? || n.empty?
    end
    ret_arr
  end
end
