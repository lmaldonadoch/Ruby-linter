require_relative '../lib/linterclass.rb'
require './lib/modules/linter.rb'

describe LinterClass do
  include Linter
  let(:arr) do
    ['def bubble_sort(arr)',
     'ordered = 1',
     '  cont = 1',
     '  while ordered.positive?',
     '    ordered = 0',
     '    (arr.length - cont.times do |i|    ',
     '      next unless arr[i]>arr[i+ 1]',
     '',
     '      temp = arr[i + 1',
     '      arr[i + 1] = arr[i]',
     '      arr[i] = temp',
     '      ordered += 1',
     '    end',
     '    cont += 1',
     '  end',
     "  p arr + 'djfvnsdjivnsdlfvndjkvndkvnsdvndskjvndskfjv'",
     'end',
     '',
     '',
     '']
  end

  let(:arr_missing_block) do
    ['def bubble_sort(arr)',
     'ordered = 1',
     '  cont = 1',
     '  while ordered.positive?',
     '    ordered = 0',
     '    (arr.length - cont.times do |i|    ',
     '      next unless arr[i]>arr[i+ 1]',
     '',
     '      temp = arr[i + 1',
     '      arr[i + 1] = arr[i]',
     '      arr[i] = temp',
     '      ordered += 1',
     '    end',
     '    cont += 1',
     "  p arr + 'djfvnsdjivnsdlfvndjkvndkvnsdvndskjvndskfjv'",
     'end',
     '',
     '',
     '']
  end
  let(:arr_indented) do
    ['def bubble_sort(arr)',
     '  ordered = 1',
     '  cont = 1',
     '  while ordered.positive?',
     '       ordered = 0',
     '    (arr.length - cont.times do |i|    ',
     '      next unless arr[i]>arr[i+ 1]',
     '',
     '    temp = arr[i + 1',
     '      arr[i + 1] = arr[i]',
     '      arr[i] = temp',
     '      ordered += 1',
     '    end',
     '    cont += 1',
     '  end',
     "  p arr + 'djfvnsdjivnsdlfvndjkvndkvnsdvndskjvndskfjv'",
     'end',
     '',
     '',
     '']
  end
  let(:linter) { LinterClass.new(arr, 50, 8, 2, 2) }
  let(:linter_indented) { LinterClass.new(arr_indented, 50, 5, 5, 2) }
  let(:linter_missing_block) { LinterClass.new(arr_missing_block, 50, 5, 5, 2) }
  describe '#validate' do
    it 'Runs the validations, creates the arrays of errors and returns the blocks dictionary' do
      expect(linter_indented.validate('Y')).to eql([[1, 0, 17], [4, 1, 15], [6, 2, 13]])
    end

    it 'Returns the lines with missing parenthesis and which parenthesis is missing' do
      linter.validate('Y')
      expect(linter.missing_parenthesis).to eql(["Line 6 has more '(' than ')'",
                                                 "Line 9 has more '[' than ']'"])
    end

    it 'Runs the lines that excede the maximum length given' do
      linter.validate('Y')
      expect(linter.line_length_errors).to eql([["Line 16 doesn't satisfy the maximum line length of 50"]])
    end

    it 'Returns the blocks who are larger than the given size' do
      linter.validate('Y')
      expect(linter.block_errors).to eql(["Block starting at 1 doesn't satisfy the maximum block length of 2",
                                          "Block starting at 4 doesn't satisfy the maximum block length of 2"])
    end

    it 'Returns the lines which end with empty spaces' do
      linter.validate('Y')
      expect(linter.trailing_space_errors).to eql([['Line 6 ends with trailing space']])
    end

    it 'Returns empty lines which have another preceding empty line' do
      linter.validate('Y')
      expect(linter.multiple_empty_lines_errors).to eql([['Line 19 is preceded by another empty line'],
                                                         ['Line 20 is preceded by another empty line']])
    end

    it 'Returns the lines with not the correct indentation' do
      linter.validate('Y')
      expect(linter.line_indentation_errors).to eql([])
    end

    it 'Returns a warning stating that there is missing an empty line at end of file' do
      linter.validate('Y')
      expect(linter.empty_line_eof_errors).to eql([])
    end

    it 'Returns the lines in which operators do not have the correct surrounding spaces' do
      linter.validate('Y')
      expect(linter.operator_spacing_errors).to eql(['Line 7 has wrong spacing around operator +',
                                                     'Line 7 has wrong spacing around operator >'])
    end

    it 'Returns the blocks that were not closed' do
      linter_missing_block.validate('Y')
      expect(linter_missing_block.block_not_closed).to eql(['Block starting on line 4 is not closed'])
    end
  end

  describe '#check_indentation' do
    it 'Returns the indentation errors' do
      expect(linter.check_indentation).to eql(['Line 2 should have 2 spaces', 'Line 2 should have 2 spaces'])
    end
  end

  describe '#indentation_autocorrect' do
    it 'Returns the array of strings with the correct indentation' do
      expect(linter.indentation_autocorrect).to eql(['def bubble_sort(arr)', '  ordered = 1',
                                                     '  cont = 1',
                                                     '  while ordered.positive?',
                                                     '    ordered = 0',
                                                     '    (arr.length - cont.times do |i|    ',
                                                     '      next unless arr[i]>arr[i+ 1]',
                                                     '',
                                                     '      temp = arr[i + 1',
                                                     '      arr[i + 1] = arr[i]',
                                                     '      arr[i] = temp',
                                                     '      ordered += 1',
                                                     '    end',
                                                     '    cont += 1',
                                                     '  end',
                                                     "  p arr + 'djfvnsdjivnsdlfvndjkvndkvnsdvndskjvndskfjv'",
                                                     'end',
                                                     '',
                                                     '',
                                                     ''])
    end
  end

  describe '#autocorrect' do
    it 'Corrects most style issues. It does not return anything but we can check each error list' do
      expect(linter_indented.autocorrect).to eql([])
    end

    it 'Trailing spaces should have been removed' do
      linter_indented.autocorrect
      expect(linter_indented.trailing_space_errors).to eql([])
    end

    it 'Multiple lines should have been removed' do
      linter_indented.autocorrect
      expect(linter_indented.multiple_empty_lines_errors).to eql([])
    end

    it 'Operator spacing should have been removed' do
      linter_indented.autocorrect
      expect(linter_indented.operator_spacing_errors).to eql([])
    end

    it 'An mpty line should have been added to the end of file if there was none' do
      linter_indented.autocorrect
      expect(linter_indented.empty_line_eof_errors).to eql([])
    end
  end
end
