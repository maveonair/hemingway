require 'test_helper'

class Repository::Github::RemoveDeploymentServiceTest < ActiveSupport::TestCase
  test 'remove repository and deploy keys' do
    octokit = mock()
    octokit.expects(:remove_deploy_key).with(any_parameters).at_least_once
    Repository::Github::RemoveDeploymentService.any_instance.stubs(:octokit).returns(octokit)

    maveonair = users(:maveonair)
    kado = repositories(:kado)

    service = Repository::Github::RemoveDeploymentService.new(maveonair, kado)
    service.destroy!

    assert kado.destroyed?
  end
end
