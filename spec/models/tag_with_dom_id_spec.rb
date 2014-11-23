require_relative "../../app/models/tag_with_dom_id"

describe TagWithDomId, "#dom_id" do
  it "returns an id for the tag" do
    tag = double(:tag, name: "Test Driven Development")
    expect(TagWithDomId.new(tag).dom_id).to eq "tag-test-driven-development"
  end
end
