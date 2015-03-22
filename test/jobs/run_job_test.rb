require 'test_helper'

class RunJobTest < ActiveJob::TestCase
  test 'a successful run' do
    Rugged::Repository.stubs(:clone_at).returns(OpenStruct.new(
      last_commit: OpenStruct.new(author: {name: 'maveonair'},
                                  oid: '4321DCBD',
                                  message: 'intial commit')))

    RubocopWrapper.any_instance.stubs(:analyze_code).returns(OpenStruct.new(
      passed: true,
      result: 'some result'))

    phrase = repositories(:phrase)

    job = RunJob.new
    job.perform(phrase.id)

    run =  Run.find_by_revision('4321DCBD')
    assert run.present?
    assert run.passed?
    assert_equal phrase, run.repository
    assert_equal 'some result', run.result
  end

  test 'only one run per revision is done' do
    phrase_run = runs(:phrase_run)

    Rugged::Repository.stubs(:clone_at).returns(OpenStruct.new(
      last_commit: OpenStruct.new(author: {name: phrase_run.author},
                                  oid: phrase_run.revision,
                                  message: phrase_run.log)))

    Rails.logger.expects(:info).with("Repo: #{phrase_run.repository.name} - Known revision: #{phrase_run.revision}")

    job = RunJob.new
    job.perform(phrase_run.repository.id)
  end
end
