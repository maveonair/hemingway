class Run::ChartBar
  def initialize(run)
    @run = run
  end

  def conventions
    pixels_in_percentage(statistic.total_conventions)
  end

  def warnings
    pixels_in_percentage(statistic.total_warnings)
  end

  def errors
    pixels_in_percentage(statistic.total_errors)
  end

  def fatals
    pixels_in_percentage(statistic.total_fatals)
  end

  private

  def pixels_in_percentage(value)
    value * 100 / baseline
  end

  def baseline
    @baseline ||= @run.summary.total_offenses.to_f
  end

  def statistic
    @statistic ||= @run.statistic
  end
end
