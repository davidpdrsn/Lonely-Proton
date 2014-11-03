require 'delegate'

class PostWithPrettyDate < SimpleDelegator
  def pretty_date
    created_at.to_s.split(' ').first.split('-').reverse.join('/')
  end
end
