class RepositoryDecorator < Draper::Decorator
  delegate_all

  def runs
    RunDecorator.decorate_collection(model.runs)
  end

  def offenses?
    last_run.present? ? last_run.summary.offenses? : false
  end

  def passed?
    last_run.present? ? last_run.passed? : false
  end

  def chart_bar
    @chart_bar ||= Run::ChartBar.new(last_run)
  end

  def last_run_at
    if last_run.present?
      "Last run #{h.time_ago_in_words(last_run.created_at)} ago"
    else
      'No inspections'
    end
  end

  private

  def last_run
    @last_run ||= model.runs.order(created_at: :desc).first
  end
end
