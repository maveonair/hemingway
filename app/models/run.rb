class Run < ActiveRecord::Base
  belongs_to :repository

  validates :author, presence: true
  validates :revision, presence: true
  validates :repository, presence: true

  delegate :name, to: :repository

  default_scope { order(sequence: :desc) }

  before_create :set_sequence

  def summary
    @summary ||= Run::Summary.new(parsed_result)
  end

  def inspections
    @inspections ||= Run::Inspection.build(parsed_result[:files])
  end

  def inspection(file_path)
    inspections.select { |inspection| inspection.file_path == file_path }.first
  end

  def parsed_result
    @parsed__result ||= JSON.parse(result, symbolize_names: true)
  end

  def statistic
    @statistic ||= Run::Statistic.new(self)
  end

  private

  def set_sequence
    self.sequence = repository.runs.count + 1
  end
end
