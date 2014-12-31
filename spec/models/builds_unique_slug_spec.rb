require "rails_helper"

describe BuildsUniqueSlug do
  it "builds a unique slug" do
    post = build :post, title: "JavaScript"
    slug = BuildsUniqueSlug.new.unique_slug(post)

    expect(slug).to eq "javascript"
  end

  it "builds a unique slug even if there is another post with the same title" do
    create :post, title: "JavaScript", slug: "javascript"
    create :post, title: "another JavaScript", slug: "javascript-1"
    post = build :post, title: "JavaScript"
    slug = BuildsUniqueSlug.new.unique_slug(post)

    expect(slug).to eq "javascript-2"
  end
end
