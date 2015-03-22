class Run < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  belongs_to :repository

  validates :author, presence: true
  validates :revision, presence: true
  validates :repository, presence: true

  delegate :name, to: :repository

  before_create :set_sequence

  def self.latest_run
    # See default_scope
    first
  end

  def self.revision?(revision)
    exists?(revision: revision)
  end

  def status
    return :success if passed?
    return :failed if statistic.errors?

    :violated
  end

  def summary
    @summary ||= Run::Summary.new(parsed_result)
  end

  def inspections
    @inspections ||= Run::Inspection.build(parsed_result[:files])
  end

  def inspection(file_path)
    inspections.find { |inspection| inspection.file_path == file_path }
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
