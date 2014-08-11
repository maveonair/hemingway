class RunDecorator < Draper::Decorator
  delegate_all

  def commit
    model.commit.first(8)
  end
end
