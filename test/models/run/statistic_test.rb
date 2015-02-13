require 'test_helper'

class Run::StatisticTest < ActiveSupport::TestCase
  test 'return the statistic of a run' do
    last_run = runs(:phrase_run)
    statistic = last_run.statistic

    assert_equal statistic.total_conventions, 44
    assert_equal statistic.total_warnings, 12
    assert_equal statistic.total_errors, 0
    assert_equal statistic.total_fatals, 0
    assert_not statistic.errors?

    assert statistic.measurements.any?
    measurement = statistic.measurements.detect { |m| m.label == 'convention'}
    assert_equal measurement.value, 44
  end
end
