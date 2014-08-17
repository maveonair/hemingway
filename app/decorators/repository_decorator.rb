class RepositoryDecorator < Draper::Decorator
  delegate_all

  def runs
    RunDecorator.decorate_collection(model.runs)
  end

  def errors?
    last_run.present? ? last_run.statistic.errors? : false
  end

  def chart_bar
    @chart_bar ||= Run::ChartBar.new(last_run)
  end

  def last_run_at
    "Last run #{h.time_ago_in_words(model.created_at)} ago"
  end

  private

  def last_run
    @last_run ||= model.runs.order('created_at').last
  end
end
