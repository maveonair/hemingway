class Repository::Github::RemoveDeploymentService < Repository::Github::RepositoryService
  def initialize(user, repository)
    super(user)
    @repository = repository
  end

  def destroy!
    octokit.remove_deploy_key(@repository.name, credentials.external_key_id)
    @repository.destroy!
  end

  private

  def credentials
    @repository.credential
  end
end
