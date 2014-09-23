class HTMLWithPygments < Redcarpet::Render::HTML
  def block_html(code)
    Pygments.highlight(code, lexer: :ruby)
  end
end
