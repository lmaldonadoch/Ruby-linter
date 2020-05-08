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
                    'Indentation errors:']
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

  def validate_empty
    ret_arr = []
    @errors.each_with_index do |n, i|
      ret_arr << i unless n.nil? || n.empty?
    end
    ret_arr
  end

  def print_errors
    error_arr = validate_empty

    error_arr.each do |n|
      puts @errors_text[n]
      @errors[n].each { |m| puts m }
      puts ''
    end

    # unless @errors[0].nil? || @errors[0].empty?
    #   puts
    #   @errors[0].each { |n| puts n }
    #   puts ''
    # end
    # unless @errors[1].nil? || @errors[1].empty?
    #   puts
    #   @errors[1].each { |n| puts n }
    #   puts ''
    # end
    # unless @errors[2].nil? || @errors[2].empty?
    #   puts
    #   @errors[2].each { |n| puts n }
    #   puts ''
    # end
    # unless @errors[3].nil? || @errors[3].empty?
    #   puts
    #   @errors[3].each { |n| puts n }
    #   puts ''
    # end
    # unless @errors[4].nil? || @errors[4].empty?
    #   puts
    #   @errors[4].each { |n| puts n }
    #   puts ''
    # end
    # unless @errors[5].nil? || @errors[5].empty?
    #   puts
    #   @errors[5].each { |n| puts n }
    #   puts ''
    # end
    # unless @errors[6].nil? || @errors[6].empty?
    #   puts
    #   @errors[6].each { |n| puts n }
    #   puts ''
    # end
    # unless @errors[7].nil? || @errors[7].empty?
    #   puts
    #   @errors[7].each { |n| puts n }
    # end
  end
end
