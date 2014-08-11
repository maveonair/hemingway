class Run::Worker
  include Sidekiq::Worker

  sidekiq_options :retry => false

  def perform(repository_id)
    @repository = Repository.find(repository_id)
    @working_directory = Dir.mktmpdir

    begin
      run!
    ensure
      FileUtils.remove_entry(@working_directory)
      @repository.unlock!
    end
  end

  def run!
    commit = git_checkout
    passed, result = analyze_code

    run = @repository.runs.build(:commit => commit, :passed => passed, :result => result)
    run.save!
  end

  private

  def git_checkout
    Dir.chdir(@working_directory) do
      git_clone = "git clone #{@repository.github_url} #{@working_directory}"
      system(*git_clone)

      git_commit_revision
    end
  end

  def git_commit_revision
    `git rev-parse HEAD`.strip
  end

  def analyze_code
    Dir.chdir(@working_directory) do
      command = ['rubocop']
      command.concat(['--format', 'json', '--out', json_file_path, '--force-exclusion'])
      passed = system(*command)
      return passed, File.read(json_file_path)
    end
  end

  def json_file_path
    @json_file_path ||= "#{@working_directory}/results.json"
  end
end
