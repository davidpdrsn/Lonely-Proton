require "rails_helper"

describe "searches/index.haml" do
  it "shows the results" do
    post = PostWithPrettyDate.new(build_stubbed(:post))
    allow(post).to receive(:html).and_return("")
    results = double(query: "JavaScript", posts: [post], has_posts?: true)
    assign :results, results

    render

    expect(rendered).to match /#{post.title}/
  end

  it "shows when there are no results" do
    results = double(query: "JavaScript", posts: [], has_posts?: false)
    assign :results, results

    render

    expect(rendered).to match "No results"
  end

  it "shows what the query was" do
    results = double(query: "ember js", posts: [], has_posts?: false)
    assign :results, results

    render

    expect(rendered).to match "\"ember js\""
  end
end

