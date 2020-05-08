module FileValidate
  def file_validate
    return 'The file does not exist. Please make sure your path is correct' unless File.exist?(self)
    return 'The file is not a ruby file. Please select a ruby file with extension .rb' unless File.extname(self) == '.rb'
    return 'The file is empty. TOTAL ERRORS 0' if File.zero?(self)
    true
  end
end