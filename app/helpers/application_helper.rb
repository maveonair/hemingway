module ApplicationHelper
  def octicon(code)
    content_tag :span, '', :class => "octicon octicon-#{code.to_s.dasherize}"
  end

  def mega_octicon(code)
    content_tag :span, '', :class => "mega-octicon octicon-#{code.to_s.dasherize}"
  end

  def sequence_label(run)
    color_class = run.passed? ? 'label-success' : 'label-danger'
    content_tag :span, run.sequence, :class => "label #{color_class}"
  end
end
