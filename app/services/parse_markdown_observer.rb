class ParseMarkdownObserver
  def initialize(parser)
    @parser = parser
  end

  def saved(record)
    record.html = @parser.parse(record.markdown)
  end

  alias_method :updated, :saved
end
