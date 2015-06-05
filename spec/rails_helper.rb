if ENV["CODECLIMATE_REPO_TOKEN"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

ENV["RAILS_ENV"] ||= "test"
require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "capybara/rails"
require "shoulda/matchers"
require "database_cleaner"
require "payload/testing"

Capybara.javascript_driver = :webkit

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("lib/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("app/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Payload::Testing

  config.use_transactional_fixtures = true

  config.include FactoryGirl::Syntax::Methods

  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.before(:each, js: true) do
    page.driver.browser.url_blacklist = ["http://fonts.googleapis.com"]
  end

  config.around(:each, :caching) do |example|
    caching = ActionController::Base.perform_caching
    ActionController::Base.perform_caching = example.metadata[:caching]
    example.run
    Rails.cache.clear
    ActionController::Base.perform_caching = caching
  end
end
