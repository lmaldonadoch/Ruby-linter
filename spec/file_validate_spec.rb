require './lib/modules/file_validate.rb'

describe FileValidate do
  include FileValidate
  let(:linter_rspec_file) { './spec/linter_module_spec.rb' }
  let(:err) { './spec/linter_spec2.rb' }
  let(:rubo) { './.rubocop.yml' }
  describe '#file_validate' do
    it 'Returns true if file exists, is a ruby file and the file is not empty' do
      expect(file_validate(linter_rspec_file)).to eql(true)
    end

    it 'Returns an error when a file does not exist' do
      expect(file_validate(err)).to eql('The file does not exist. Please make sure your path is correct')
    end

    it 'Returns an error when the file exists but it is not a ruby file' do
      expect(file_validate(rubo)).to eql('The file is not a ruby file. Please select a ruby file with extension .rb')
    end
  end
end
