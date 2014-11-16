require "rails_helper"

describe Api::MarkdownParserController do
  describe "#parse" do
    it "uses MarkdownParser to parse some markdown and render it" do
      markdown = "**hi**"
      parser = double("parser", parse: "<strong>hi</strong>")
      allow(MarkdownParser).to receive(:new).and_return(parser)

      post :parse, markdown: markdown

      expect(parser).to have_received(:parse).with(markdown)
      expect(response.body).to eq "<strong>hi</strong>"
    end
  end
end
