class Repository::Github::RepositoryService < Repository::Github::Service
  def initialize(user, organization_id = nil)
    super(user)
    @organization_id = organization_id.try(:to_i)
  end

  def tested_repos
    @tested_repos ||= user.repositories
  end

  def untested_repos
    @untested_repos ||= repositories_names - tested_repos.map(&:name)
  end

  def repositories
    @repositories ||= owned_repositories.select { |r| r.language == 'Ruby' }
  end

  def repositories_names
    repositories.map(&:full_name)
  end

  def organizations
    @organizations ||= octokit.organizations.map do |organization|
      OpenStruct.new(id: organization.id,
                     name: organization.login,
                     avatar_url: organization.avatar_url)
    end
  end

  protected

  attr_reader :organization_id

  def owned_repositories
    organization_id.present? ? all_owned_organisation_repositories : owned_personal_repositories
  end

  def owned_personal_repositories
    octokit.repos.select { |r| r.permissions.admin? }
  end

  def all_owned_organisation_repositories
    # We are able only to get 200 repositories back with this code.
    # Probably we should implement a proper pagiation
    repositories = owned_organization_repositories

    if repositories.any? && octokit.last_response.rels[:next].present?
      repositories.concat(octokit.last_response.rels[:next].get.data)
    end

    repositories
  end

  def owned_organization_repositories
    organization_repositories.select { |r| r.permissions.admin? }
  end

  def organization_repositories
    octokit.org_repos(organization_id, per_page: 100)
  end
end
