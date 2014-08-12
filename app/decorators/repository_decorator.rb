class RepositoryDecorator < Draper::Decorator
  delegate_all

  def runs
    RunDecorator.decorate_collection(model.runs)
  end
end
