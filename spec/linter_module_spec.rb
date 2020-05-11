require './lib/modules/linter_module.rb'

describe Linter do
  include Linter
  let(:block_string_if) { 'if something' }
  let(:block_string_do) { 'something.each do' }
  let(:block_string_do_variable) { 'something.each do |n|' }
  let(:block_string_def) { 'def something()' }

  describe '#block?' do
    it 'Returns true when the first word is an if' do
      expect(block_string_if.block?).to eql(true)
    end

    it 'Returns false when the there is an if in the string but it is not the first word' do
      expect('do this if that'.block?).to eql(false)
    end

    it 'Returns true when the last word is do' do
      expect(block_string_do.block?).to eql(true)
    end

    it 'Returns true when the last part is a variable in | | and before there is a do' do
      expect(block_string_do_variable.block?).to eql(true)
    end

    it 'Returns false when the last part is a variable in | | and before there is no do' do
      expect('something.each{ |n|'.block?).to eql(false)
    end
  end

  describe '#parenthesis_even' do
    it 'Returns an array, position 0 is the element missing, position 1 is the counterpart' do
      expect(parenthesis_even('(something with no closing parenthesis')).to eql([')', '('])
    end

    it 'Returns an array, position 0 is the element missing, position 1 is the counterpart' do
      expect(parenthesis_even('something with no opening parenthesis)')).to eql(['(', ')'])
    end
  end

  describe '#brackets_even' do
    it 'Returns an array, position 0 is the element missing, position 1 is the counterpart' do
      expect(brackets_even('[something with no closing brackets')).to eql([']', '['])
    end
  end

  describe '#curly_brackets_even' do
    it 'Returns an array, position 0 is the element missing, position 1 is the counterpart' do
      expect(curly_brackets_even('something with no opening curly-brackets}')).to eql(['{', '}'])
    end
  end

  describe '#operator_validator' do
    it 'Returns an array with the operator, -1 if no space is missing or the index where a space is missing' do
      expect(operator_validator('something + something else')).to eql([['+', -1, -1]])
    end

    it 'Returns an array with the operator, -1 if no space is missing or the index where a space is missing' do
      expect(operator_validator('something += something else')).to eql([['+=', -1, -1]])
    end

    it 'Returns an array with the operator, -1 if no space is missing or the index where a space is missing' do
      expect(operator_validator('something <=something else')).to eql([['<=', -1, 12]])
    end

    it 'Returns an array with the operator, -1 if no space is missing or the index where a space is missing' do
      expect(operator_validator('something*something else')).to eql([['*', 8, 10]])
    end
  end
end
