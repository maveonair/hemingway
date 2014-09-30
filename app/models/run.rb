class Run < ActiveRecord::Base
  belongs_to :repository

  validates :author, presence: true
  validates :revision, presence: true
  validates :repository, presence: true

  delegate :name, to: :repository

  default_scope { order(created_at: :desc) }

  def self.latest_run
    # See default_scope
    first
  end

  def self.exist?(revision)
    where(revision: revision).present?
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
end
