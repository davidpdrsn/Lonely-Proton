Konacha.configure do |config|
  require "capybara/webkit"
  config.driver = :webkit
end if defined?(Konacha)
