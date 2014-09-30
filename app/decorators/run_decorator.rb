class RunDecorator < Draper::Decorator
  delegate_all

  def revision
    model.revision.first(8)
  end

  def created_at
    h.time_ago_in_words(model.created_at)
  end
end
