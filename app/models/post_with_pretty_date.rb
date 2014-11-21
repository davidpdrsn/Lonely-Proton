require "delegate"

# Post decorator that prettifies the created_at
class PostWithPrettyDate < SimpleDelegator
  def pretty_date
    date_to_prettify.to_s.split(" ").first.split("-").reverse.join("/")
  end

  private

  def date_to_prettify
    published_at || created_at
  end
end
