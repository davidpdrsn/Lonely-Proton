require 'rails_helper'

describe TagWithDomId, "#dom_id" do
  it 'returns an id for the tag' do
    tag = create :tag, name: "Test Driven Development"
    expect(TagWithDomId.new(tag).dom_id).to eq "tag-test-driven-development"
  end
end
