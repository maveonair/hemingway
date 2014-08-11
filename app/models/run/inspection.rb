class Run::Inspection
  def initialize(file)
    @file = file
  end

  def file_path
    @file[:path]
  end

  def offenses
    @offenses ||= @file[:offenses].map do |offense|
      Run::Offense.new(offense)
    end
  end

  def self.build(files)
    files.map do |file|
      new(file) if file[:offenses].any?
    end.compact
  end
end
