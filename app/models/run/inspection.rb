class Run::Inspection
  def initialize(file)
    @file = file
  end

  def file_path
    file[:path]
  end

  def encoded_file_path
    Base64.urlsafe_encode64(file_path)
  end

  def offenses
    @offenses ||= file[:offenses].map do |offense|
      Run::Offense.new(offense)
    end
  end

  def offenses_at(line_number)
    offenses.select { |offense| offense.location[:line] == line_number }
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

  def self.build(files)
    files.map do |file|
      new(file) if file[:offenses].any?
    end.compact
  end

  def severities
    @severities ||= offenses.flatten.map(&:severity)
  end

  private

  attr_reader :file

  def measurements
    @measurements ||= Run::Measurement.build(severities)
  end

  def total_severity(symbol)
    measurement = measurements.select { |m| m.label == symbol.to_s }.first
    measurement.present? ? measurement.value : 0
  end
end
