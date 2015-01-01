require "rails_helper"

describe Api::MarkdownParserController do
  describe "#parse" do
    it "uses MarkdownParser to parse some markdown and render it" do
      markdown = "**hi**"
      parser = stub_service(:markdown_parser)
      allow(parser).to receive(:parse).and_return("<strong>hi</strong>")

      post :parse, markdown: markdown

      expect(parser).to have_received(:parse).with(markdown)
      expect(response.body).to eq "<strong>hi</strong>"
    end
  end
end
