module InspectionHelper
  def render_code(code, inspection)
    find_and_preserve(enriched_html(code, inspection))
  end

  private

  def enriched_html(code, inspection)
    html = highlighted_html(code)

    index = 0
    html.lines.map do |line|
      index += 1
      enrich_code_line(inspection, line, index)
    end.join('')
  end

  def highlighted_html(code)
    encoded = code.dup.force_encoding('UTF-8')
    Pygments.highlight(encoded, lexer: :ruby)
  end

  def enrich_code_line(inspection, line, index)
    offense = inspection.offense(index)

    if offense.present?
      message = message_content_tag(offense.message, offense.severity)
      enriched_line = code_line_tag(line, offense.severity)

      "#{message}\n#{enriched_line}"
    else
      line
    end
  end

  def message_content_tag(text, severity)
    content_tag(:span, text, class: "label-severity-#{severity}")
  end

  def code_line_tag(line, severity)
    content_tag(:span, line.html_safe, class: "code-severity-#{severity}")
  end
end
