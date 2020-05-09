# rubocop:disable Layout/LineLength
require './lib/modules/file_validate.rb'

describe FileValidate do
  include FileValidate
  describe '#file_validate' do
    it 'Returns true if file exists, is a ruby file and the file is not empty' do
      expect(file_validate('/home/luis/Desktop/microverse/Ruby/ruby-linter/spec/linter_spec.rb')).to eql(true)
    end

    it 'Returns an error when a file does not exist' do
      expect(file_validate('/home/luis/DesktopRuby/ruby-linter/spec/linter_spec.rb')).to eql('The file does not exist. Please make sure your path is correct')
    end

    it 'Returns an error when the file exists but it is not a ruby file' do
      expect(file_validate('/home/luis/Desktop/microverse/Ruby/ruby-linter/.rubocop.yml')).to eql('The file is not a ruby file. Please select a ruby file with extension .rb')
    end

    it 'Returns an error when the file exists, has a ruby extension but is empty' do
      expect(file_validate('/home/luis/Desktop/microverse/Ruby/ruby-linter/dummy.rb')).to eql('The file is empty. TOTAL ERRORS 0')
    end
  end
end
# rubocop:enable Layout/LineLength
