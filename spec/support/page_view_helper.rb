def page
  render
  Capybara::Node::Simple.new(rendered)
end
