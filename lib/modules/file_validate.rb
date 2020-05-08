module FileValidate
  def file_validate(file)
    return 'The file does not exist. Please make sure your path is correct' unless File.exist?(file)
    unless File.extname(file) == '.rb'
      return 'The file is not a ruby file. Please select a ruby file with extension .rb'
    end
    return 'The file is empty. TOTAL ERRORS 0' if File.zero?(file)

    true
  end
end
