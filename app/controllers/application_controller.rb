# The application controller
class ApplicationController < ActionController::Base
  include Payload::Controller

  protect_from_forgery with: :exception

  def require_authentication
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["admin_username"] && password == ENV["admin_password"]
    end
  end
end
