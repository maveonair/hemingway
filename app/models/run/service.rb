class Run::Service
  def initialize(repository)
    @repository = repository
  end

  def run!
    if @repository.unlocked?
      @repository.lock!
      Run::Worker.perform_async(@repository.id)
    end
  end
end
