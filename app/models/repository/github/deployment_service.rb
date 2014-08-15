class Repository::Github::DeploymentService < Repository::Github::Service
  def initialize(user, params)
    super(user)
    @params = params
  end

  def save
    enrich_repository
    add_deploy_key
    repository.save
  rescue => exception
    Rails.logger.error(exception)
    false
  end

  def repository
    @repository ||= @user.repositories.build(@params).tap do |model|
      model.credential = Credential.build_with_keys
    end
  end

  private

  def enrich_repository
    repository.html_url = repository_details.html_url
    repository.ssh_url = repository_details.ssh_url
  end

  def repository_details
    @repository_details ||= octokit.repo(repository.name)
  end

  def add_deploy_key
    octokit.add_deploy_key(repository.name, 'hemingway-deploy-key', credentials.public_key)
  end

  def credentials
    repository.credential
  end
end
