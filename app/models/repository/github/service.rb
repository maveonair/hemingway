class Repository::Github::Service
  def initialize(user)
    @user = user
  end

  protected

  attr_reader :user

  def octokit
    @octokit ||= Octokit::Client.new(access_token: user.token)
  end
end
