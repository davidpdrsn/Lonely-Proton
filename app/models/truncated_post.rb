require "delegate"

# Decorator that truncates the markdown of a post and reparses the HTML
class TruncatedPost < SimpleDelegator
  def initialize(post, length:, markdown_parser:, truncate_method:)
    super(post)
    @markdown_parser = markdown_parser
    @truncate_method = truncate_method
    @length = length
  end

  def markdown
    @truncate_method.call(__getobj__.markdown, length: @length)
  end

  def html
    @markdown_parser.parse(markdown)
  end
end
