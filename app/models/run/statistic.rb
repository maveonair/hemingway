class Run::Statistic
  def initialize(run)
    @run = run
  end

  def severities_count
    measurements.map do |measurement|
      {
        :label => measurement.label,
        :value => measurement.value,
        :color => colors[measurement.label.to_sym]
      }
    end.to_json
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

  def measurements
    @measurements ||= severities.group_by { |s| s}.map do |k, v|
      OpenStruct.new(:label => k, :value => v.count)
    end
  end

  private

  def total_severity(symbol)
    measurement = measurements.select { |m| m.label == symbol.to_s}.first
    measurement.present? ? measurement.value : 0
  end

  def severities
    @severities ||= @run.inspections.map(&:severities).flatten
  end

  def colors
    {
      :convention => '#FECEA8',
      :warning => '#FF847C',
      :refactor => '#2A363B',
      :error => '#E84A5F',
      :fatal => '#F7464A'
    }
  end
end
