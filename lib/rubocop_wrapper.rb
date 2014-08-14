class RubocopWrapper
  def initialize(working_directory)
    @working_directory = working_directory
  end

  def analyze_code
    Dir.chdir(@working_directory) do
      command = ['rubocop']
      command.concat(['--format', 'json', '--out', json_file_path, '--force-exclusion'])
      passed = system(*command)

      OpenStruct.new(passed: passed, result: File.read(json_file_path))
    end
  end

  def json_file_path
    @json_file_path ||= "#{@working_directory}/results.json"
  end
end
