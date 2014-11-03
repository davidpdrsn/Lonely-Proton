require 'rails_helper'

describe Api::MarkdownParserController do
  describe '#parse' do
    it 'parses markdown' do
      post :parse, markdown: "**hi**"
      expect(response.body).to include "<strong>hi</strong>"
    end
  end
end
