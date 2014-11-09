module Api
  # Controller that makes it possible to have markdown parse over HTTP
  class MarkdownParserController < ApplicationController
    def parse
      render text: MarkdownParser.new.parse(params[:markdown])
    end
  end
end
