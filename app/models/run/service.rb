class Run::Service
  def initialize(repository)
    @repository = repository
  end

  def run!
    return if @repository.locked?

    @repository.lock!
    Run::Worker.perform_async(@repository.id)
  end
end
