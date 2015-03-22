class Run::Service
  def initialize(repository)
    @repository = repository
  end

  def run!
    return if repository.locked?

    repository.lock!
    RunJob.perform_later(repository.id)
  end

  private

  attr_reader :repository
end
