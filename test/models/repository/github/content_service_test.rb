require 'test_helper'

class Repository::Github::ContentServiceTest < ActiveSupport::TestCase
  test 'return the content' do
    octokit = mock()
    octokit.expects(:contents).with(any_parameters).at_least_once
    Repository::Github::ContentService.any_instance.stubs(:octokit).returns(octokit)

    maveonair = users(:maveonair)
    phrase = repositories(:phrase)
    run = phrase.latest_run
    inspection = run.inspections.first

    service = Repository::Github::ContentService.new(maveonair)
    service.contents(phrase.name, run.revision, inspection.file_path)
  end
end
