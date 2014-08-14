class RunDecorator < Draper::Decorator
  delegate_all

  def sequence
    "##{model.sequence}"
  end

  def revision
    model.revision.first(8)
  end

  def status
    return success_label if model.passed?
    return failed_label if model.statistic.errors?
    
    violated_label
  end

  private

  def success_label
    label('Success', 'success')
  end

  def failed_label
    label('Failed', 'danger')
  end

  def violated_label
    label('Violated', 'warning')
  end

  def label(label, label_class)
    h.content_tag(:span, label, class: "label label-#{label_class}")
  end
end
