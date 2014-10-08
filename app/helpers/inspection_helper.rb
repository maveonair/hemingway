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
    utf8_encoded_code = code.dup.force_encoding('UTF-8')
    Pygments.highlight(utf8_encoded_code, lexer: :ruby)
  end

  def enrich_code_line(inspection, line, index)
    offenses = inspection.offenses_at(index)

    if offenses.any?
      enriched_code_line(offenses, line)
    else
      line
    end
  end

  def enriched_code_line(offenses, line)
    messages = messages(offenses)
    enriched_line = code_line_tag(line, offenses.first.severity)
    "#{messages.join('<br>')}\n#{enriched_line}"
  end

  def messages(offenses)
    offenses.map do |offense|
      message_content_tag(offense.message, offense.severity)
    end.uniq
  end

  def message_content_tag(text, severity)
    content_tag(:span, text, class: "label-severity-#{severity}")
  end

  def code_line_tag(line, severity)
    content_tag(:span, line.html_safe, class: "code-severity-#{severity}")
  end
end
