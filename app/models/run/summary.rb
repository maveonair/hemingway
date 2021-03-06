class Run::Summary
  def initialize(result)
    @summary = result[:summary]
  end

  def offenses?
    total_offenses > 0
  end

  def total_offenses
    summary[:offense_count]
  end

  def total_files
    summary[:target_file_count]
  end

  def total_inspected_files
    summary[:inspected_file_count]
  end

  private

  attr_reader :summary
end
