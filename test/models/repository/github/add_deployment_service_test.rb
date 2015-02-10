require 'test_helper'

class Repository::Github::AddDeploymentServiceTest < ActiveSupport::TestCase
  test 'add a repository and deploy keys' do
    octokit = mock()
    octokit.expects(:add_deploy_key).with(any_parameters).at_least_once.returns(OpenStruct.new(id: 42))
    octokit.expects(:repo).with(any_parameters).at_least_once.returns(OpenStruct.new(
                          html_url: 'https://github.com/maveonair/hemingway',
                          ssh_url: 'git@github.com:maveonair/hemingway.git'))
    Repository::Github::AddDeploymentService.any_instance.stubs(:octokit).returns(octokit)

    maveonair = users(:maveonair)

    service = Repository::Github::AddDeploymentService.new(maveonair, { name: 'maveonair/hemingway' })
    assert service.save
  end
end
