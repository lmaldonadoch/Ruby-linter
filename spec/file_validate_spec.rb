require './lib/modules/file_validate.rb'

describe FileValidate do
  include FileValidate
  describe '#file_validate' do
    it 'Returns true if file exists' do
    expect(file_validate('/home/luis/Desktop/microverse/Ruby/ruby-linter/spec/linter_spec.rb')).to eql(true)
    end
  end
  
end