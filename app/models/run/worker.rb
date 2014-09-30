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

    if Run.exist?(last_commit.revision)
      logger.info("Repository: #{@repository.name} - Revision exists already: #{last_commit.revision}")
      return
    end

    rubocop_statistic = rubocop_wrapper.analyze_code
    create_run(last_commit, rubocop_statistic)
  end

  private

  def create_run(commit, rubocop_statistic)
    @repository.runs.build.tap do |run|
      run.author = commit.author
      run.revision = commit.revision
      run.log = commit.log
      run.passed = rubocop_statistic.passed
      run.result = rubocop_statistic.result
      run.save!
    end
  end

  def git_wrapper
    GitWrapper.new(@repository, @working_directory)
  end

  def rubocop_wrapper
    RubocopWrapper.new(@working_directory)
  end
end
