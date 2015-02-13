class Run::Statistic
  def initialize(run)
    @run = run
  end

  def total_conventions
    total_severity(:convention)
  end

  def total_warnings
    total_severity(:warning)
  end

  def total_errors
    total_severity(:error)
  end

  def total_fatals
    total_severity(:fatal)
  end

  def errors?
    (total_errors + total_fatals) > 0
  end

  def measurements
    @measurements ||= Run::Measurement.build(severities)
  end

  private

  attr_reader :run

  def total_severity(symbol)
    measurement = measurements.select { |m| m.label == symbol.to_s }.first
    measurement.present? ? measurement.value : 0
  end

  def severities
    @severities ||= run.inspections.map(&:severities).flatten
  end
end
