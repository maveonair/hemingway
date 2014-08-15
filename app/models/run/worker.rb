class Run::Worker
  include Sidekiq::Worker

  sidekiq_options retry: false

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
    last_commit = git_wrapper.clone
    rubocop_statistic = rubocop_wrapper.analyze_code

    @repository.runs.build.tap do |run|
      run.author = last_commit.author
      run.revision = last_commit.revision
      run.log = last_commit.log
      run.passed = rubocop_statistic.passed
      run.result = rubocop_statistic.result
      run.save!
    end
  end

  private

  def git_wrapper
    GitWrapper.new(@repository, @working_directory)
  end

  def rubocop_wrapper
    RubocopWrapper.new(@working_directory)
  end
end
