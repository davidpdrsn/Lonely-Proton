require "rails_helper"

describe "posts/edit.haml" do
  it "checks the draft checkbox if post is draft" do
    post = build_stubbed(:post, published_at: nil)
    assign_form_with_post(post)

    expect(page).to have_checked_checkbox
  end

  it "doesn't check the draft checkbox if post is published" do
    post = build_stubbed(:post, published_at: Time.now)
    assign_form_with_post(post)

    expect(page).not_to have_checked_checkbox
  end

  def assign_form_with_post(post)
    assign(:form, double(post: post, tags: [], new?: true))
  end
end
