class Run::Measurement
  attr_reader :label, :value

  def initialize(label, value)
    @label = label
    @value = value
  end

  def self.build(severities)
    severities.group_by { |s| s }.map do |k, v|
      Run::Measurement.new(k, v.count)
    end
  end
end
