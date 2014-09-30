module InspectionHelper
  def render_code(code, inspection)
    html = Pygments.highlight(code, lexer: :ruby)

    index = 1
    enriched_html = html.lines.map do |line|
      offense = inspection.offense(index)
      index = index + 1

      if offense.present?
        message = content_tag(:span, "#{offense.message}", class: "label-severity-#{offense.severity}")
        enriched_line = content_tag(:span, line.html_safe, class: "code-severity-#{offense.severity}")
        "#{message}\n#{enriched_line}"
      else
        line
      end
    end.join('')

    find_and_preserve(enriched_html)
  end

  def severity_label(severity)
    content_tag :span, severity, class: "label label-severity-#{severity}"
  end
end
