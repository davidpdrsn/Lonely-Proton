require 'delegate'

# Post decorator that prettifies the created_at
class PostWithPrettyDate < SimpleDelegator
  def pretty_date
    # TODO: prettify published at instead of created at
    # Will require new test
    created_at.to_s.split(' ').first.split('-').reverse.join('/')
  end
end
