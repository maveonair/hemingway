class Repository::Github::RemoveDeploymentService < Repository::Github::RepositoryService
  def initialize(user, repository)
    super(user)
    @repository = repository
  end

  def destroy!
    remove_deploy_key!
    repository.destroy!
  end

  private

  attr_reader :repository

  def remove_deploy_key!
    octokit.remove_deploy_key(repository.name, credentials.external_key_id)
  end

  def credentials
    repository.credential
  end
end
