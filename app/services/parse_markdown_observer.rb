# Observer that will parser a posts markdown when its saved or updated
class ParseMarkdownObserver
  pattr_initialize :parser

  def saved(record)
    record.html = @parser.parse(record.markdown)
  end

  alias_method :updated, :saved
end
