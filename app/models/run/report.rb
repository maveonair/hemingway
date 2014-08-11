class Run::Report
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

  private

  def severities
    @severities ||= @run.inspections.map(&:offenses).flatten.map(&:severity)
  end

  def measurements
    @measurements ||= severities.group_by { |s| s}.map do |k, v|
      OpenStruct.new(:label => k, :value => v.count)
    end
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
