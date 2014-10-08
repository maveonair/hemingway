module ApplicationHelper
  def octicon(code)
    content_tag :span, '', class: "octicon #{octicon_class(code)}"
  end

  def mega_octicon(code, css_class = nil)
    content_tag :span, '', class: "mega-octicon #{octicon_class(code)} #{css_class}"
  end

  private

  def octicon_class(code)
    "octicon-#{code.to_s.dasherize}"
  end
end
