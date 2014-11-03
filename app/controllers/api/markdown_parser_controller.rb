module Api
  class MarkdownParserController < ApplicationController
    def parse
      render text: MarkdownParser.new.parse(params[:markdown])
    end
  end
end
