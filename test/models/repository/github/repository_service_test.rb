require 'test_helper'

class Repository::Github::RepositoryServiceTest < ActiveSupport::TestCase
  test 'return the repositories of a user' do
    octokit = mock()
    octokit.expects(:repos).with(any_parameters).at_least_once.returns([
      OpenStruct.new(id: 42,
                     full_name: 'maveonair/hemingway',
                     language: 'Ruby',
                     private?: false,
                     permissions: OpenStruct.new(admin?: true))
                     ])
    Repository::Github::RepositoryService.any_instance.stubs(:octokit).returns(octokit)

    service = Repository::Github::RepositoryService.new(users(:maveonair))
    assert service.repositories?
    assert 'maveonair/hemingway', service.repositories.first.name
  end

  test 'return the repositories of an organization' do
    octokit = mock()
    octokit.expects(:last_response).at_least_once.returns(OpenStruct.new(rels: {}))
    octokit.expects(:org_repos).with(any_parameters).at_least_once.returns([
      OpenStruct.new(id: 42,
                     full_name: 'maveonair/powpow',
                     language: 'Ruby',
                     private?: true,
                     permissions: OpenStruct.new(admin?: true))
                     ])
    Repository::Github::RepositoryService.any_instance.stubs(:octokit).returns(octokit)

    service = Repository::Github::RepositoryService.new(users(:maveonair), 4)
    assert service.repositories?
    assert 'maveonair/powpow', service.repositories.first.name
  end

  test 'return the organizations of a user' do
    octokit = mock()
    octokit.expects(:organizations).with(any_parameters).at_least_once.returns([
      OpenStruct.new(id: 4,
                     name: 'maveonair.io',
                     avatar_url: 'http://placehold.it/100x100')
                     ])
    Repository::Github::RepositoryService.any_instance.stubs(:octokit).returns(octokit)

    service = Repository::Github::RepositoryService.new(users(:maveonair))
    assert service.organizations.any?
    assert 'maveonair.io', service.organizations.first.name
  end
end
