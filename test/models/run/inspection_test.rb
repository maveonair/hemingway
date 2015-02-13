require 'test_helper'

class Run::InspectionTest < ActiveSupport::TestCase
  test 'return the statistic of a run' do
    last_run = runs(:phrase_run)
    inspection = last_run.inspection('bin/phrase-droid')

    assert_match inspection.file_path, 'bin/phrase-droid'
    assert_match inspection.encoded_file_path, 'YmluL3BocmFzZS1kcm9pZA=='

    assert_equal inspection.total_conventions, 4
    assert_equal inspection.total_warnings, 7
    assert_equal inspection.total_errors, 0
    assert_equal inspection.total_fatals,0

    assert inspection.offenses.any?
    offsene = inspection.offenses_at(1).first
    assert_match offsene.message, 'Use snake_case for source file names.'
  end
end
