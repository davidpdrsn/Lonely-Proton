require_relative '../../lib/markdown_parser'
require 'rails_helper'

describe Post do
  it { should validate_presence_of :title }
  it { should validate_presence_of :markdown }
  it { should have_and_belong_to_many :tags }

  it 'automatically generates its html before save' do
    markdown = '**hi**'
    html = '<p><strong>hi</strong></p>'
    parser = double('markdown_parser')
    allow(parser).to receive(:parse).with(markdown).and_return(html)
    allow(MarkdownParser).to receive(:new).and_return(parser)

    post = build(:post, markdown: markdown)
    post.save

    expect(parser).to have_received(:parse).with(markdown)
    expect(post.html).to eq html
  end

  describe '#sorted' do
    it 'returns the newest post first' do
      create :post, title: "old"
      create :post, title: "new"

      expect(Post.sorted.map(&:title)).to eq ['new', 'old']
    end
  end
end
