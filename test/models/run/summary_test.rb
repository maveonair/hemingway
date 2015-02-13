require 'test_helper'

class Run::SummaryTest < ActiveSupport::TestCase
  test 'return the summary of a run' do
    last_run = runs(:phrase_run)
    summary = last_run.summary

    assert summary.offenses?
    assert_equal summary.total_offenses, 56
    assert_equal summary.total_files, 17
    assert_equal summary.total_inspected_files, 17
  end
end
