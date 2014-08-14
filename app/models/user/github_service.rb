class User::GithubService
  def initialize(user)
    @user = user
  end

  def tested_repos
    @tested_repos ||= @user.repositories
  end

  def untested_repos
    @untested_repos ||= repositories_names - tested_repos
  end

  def repositories
    @repositories ||= octokit.repos.select { |repo| repo.language == 'Ruby'}
  end

  def repositories_names
    repositories.map(&:full_name)
  end

  private

  def octokit
    @octokit ||= Octokit::Client.new(access_token: @user.token)
  end
end
