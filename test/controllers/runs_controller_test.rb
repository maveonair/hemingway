require 'test_helper'

class RunsControllerTest < ActionController::TestCase
  def setup
    login(:maveonair)
  end

  test 'show a run' do
    phrase = repositories(:phrase)
    get :show, id: phrase.latest_run.id, repository_id: phrase

    assert_response :success
  end

  test 'inspect a run' do
    Repository::Github::ContentService.any_instance.stubs(:contents).returns(OpenStruct.new(content: 'require "camelCase.rb"'))

    phrase = repositories(:phrase)
    run = runs(:phrase_run)
    inspection = run.inspection('bin/phrase-droid')

    get :inspect, id: run.id, repository_id: phrase, file_path: inspection.encoded_file_path

    assert_response :success
    assert_match 'Use snake_case for source file names.', response.body
  end
end
