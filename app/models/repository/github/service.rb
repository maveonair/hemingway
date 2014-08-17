class Repository::Github::Service
  def initialize(user)
    @user = user
  end

  def tested_repos
    @tested_repos ||= @user.repositories
  end

  def untested_repos
    @untested_repos ||= repositories_names - tested_repos.map(&:name)
  end

  def repositories
    @repositories ||= owned_repositories.select { |repo| repo.language == 'Ruby' }
  end

  def owned_repositories
    @owned_repositories ||= octokit.repos.select { |r| r.permissions.admin? }
  end

  def repositories_names
    repositories.map(&:full_name)
  end

  protected

  def octokit
    @octokit ||= Octokit::Client.new(access_token: @user.token)
  end
end
