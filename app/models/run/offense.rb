class Run::Offense
  def initialize(data)
    @data = data
  end

  def severity
    @data[:severity]
  end

  def message
    @data[:message]
  end

  def cop_name
    @data[:cop_name]
  end

  def location
    @data[:location]
  end

  def line_number
    location[:line]
  end

  def column
    location[:column]
  end
end
