require './lib/linter.rb'

describe Linter do
  include Linter
  let(:block_string_if) {'if something'}
  let(:block_string_do) {'something.each do'}
  let(:block_string_do_variable) {'something.each do |n|'}
  let(:block_string_def) {'def something()'}

  describe '#is_block?' do
    it 'Returns true when the first word is an if' do
      expect(block_string_if.is_block?).to eql(true)
    end

    it 'Returns false when the there is an if in the string but it is not the first word' do
      expect('do this if that'.is_block?).to eql(false)
    end

    it 'Returns true when the last word is do' do
      expect(block_string_do.is_block?).to eql(true)
    end

    it 'Returns true when the last part is a variable in | | and before there is a do' do
      expect(block_string_do_variable.is_block?).to eql(true)
    end

    it 'Returns false when the last part is a variable in | | and before there is no do' do
      expect('something.each{ |n|'.is_block?).to eql(false)
    end    
  end

  describe '#block_end' do
    it 'Returns 0 when there is no block end missing' do
      expect(["if 'a' == 'a'", "  [1, 2, 3].each do", "    puts 'This is a block with ending'", "  end", "end"]).to eql(4)
    end

    it 'Returns the end of the block when it exists' do
      expect(["if 'a' == 'a'", "  [1, 2, 3].each do", "    puts 'This is a block with ending'", "  end", "end", "", "[1, 2, 3].each do", "  if 'b' == 'b'", "    puts 'This block has no ending'", "  end"]).to eql(5)
    end
  end
end
