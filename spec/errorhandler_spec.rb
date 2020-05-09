require_relative '../lib/errorhandler.rb'
require_relative '../lib/modules/file_validate.rb'

describe ErrorHandler do
  include FileValidate
  let(:file) { '/home/luis/Desktop/microverse/Ruby/ruby-linter/spec/errorhandler_spec.rb' }
  let(:errors) do
    [["Line 6 seem to have more '(' than ')"], ['Line 16 does not satisfy the maximum line length given of 120'],
     ['Line 6 ends with trailing space'], ['Line 30 has wrong spacing around operator +']]
  end
  let(:error_file) { ErrorHandler.new(file) }
  let(:error_messages) { ErrorHandler.new(errors) }

  describe '#file_validations' do
    it 'Evaluates the error using the FileValidate module' do
      expect(error_file.file_validate(file)).to eql(true)
    end
  end

  describe '#total_errors' do
    it 'Returns the total ammount of errors' do
      expect(error_messages.total_errors).to eql(4)
    end
  end

  describe '#print_errors' do
    it 'Returns an array with the title of the errors, the errors and some nice spacing' do
      expect(error_messages.print_errors).to eql(['Icomplete parenthesis errors:',
                                                  ["Line 6 seem to have more '(' than ')"],
                                                  ['Line 16 does not satisfy the maximum line length given of 120'],
                                                  ['Line 6 ends with trailing space'],
                                                  ['Line 30 has wrong spacing around operator +'], ''])
    end
  end
end
