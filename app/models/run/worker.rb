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
    git_stats = git_wrapper.checkout(@repository.github_url)
    rubocop_stats = rubocop_wrapper.analyze_code

    @repository.runs.build.tap do |run|
      run.author = git_stats.author
      run.revision = git_stats.revision
      run.log = git_stats.log
      run.passed = rubocop_stats.passed
      run.result = rubocop_stats.result
      run.save!
    end
  end

  private

  def git_wrapper
    GitWrapper.new(@working_directory)
  end

  def rubocop_wrapper
    RubocopWrapper.new(@working_directory)
  end
end
