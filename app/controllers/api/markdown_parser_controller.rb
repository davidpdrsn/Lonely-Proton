module Api
  # Controller that makes it possible to have markdown parse over HTTP
  class MarkdownParserController < ApplicationController
    def parse
      render text: dependencies[:markdown_parser].parse(params[:markdown])
    end
  end
end
