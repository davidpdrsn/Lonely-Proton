source "https://rubygems.org"

ruby "2.1.4"

gem "annotate"
gem "attr_extras"
gem "autoprefixer-rails"
gem "coderay"
gem "coffee-rails", "~> 4.0.0"
gem "dalli"
gem "figaro", "~> 1.0.0"
gem "haml-rails"
gem "high_voltage"
gem "jbuilder", "~> 2.0"
gem "jquery-rails"
gem "newrelic_rpm"
gem "payload", require: "payload/railtie"
gem "pg"
gem "rails", "4.1.6"
gem "redcarpet", github: "vmg/redcarpet"
gem "rubocop"
gem "sass-rails", "~> 4.0.3"
gem "turbolinks"
gem "uglifier", ">= 1.3.0"

gem "capistrano"
gem "capistrano-bundler"
gem "capistrano-rails"
gem "capistrano-rbenv"

group :development do
  gem "foreman"
  gem "spring"
  gem "spring-commands-rspec"
end

group :test do
  gem "capybara"
  gem "capybara-webkit"
  gem "codeclimate-test-reporter", require: false
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "shoulda-matchers", require: false
  gem "timecop"
end

group :test, :development do
  gem "konacha"
  gem "launchy"
  gem "pry-rails"
  gem "rspec-rails"
end

