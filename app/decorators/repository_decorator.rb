class RepositoryDecorator < Draper::Decorator
  delegate_all

  def runs
    RunDecorator.decorate_collection(model.runs)
  end

  def offenses?
    last_run.present? ? last_run.summary.offenses? : false
  end

  def chart_bar
    @chart_bar ||= Run::ChartBar.new(last_run)
  end

  def last_run_at
    "Last run #{h.time_ago_in_words(model.created_at)} ago"
  end

  private

  def last_run
    @last_run ||= model.runs.order(created_at: :desc).first
  end
end
