source "https://rubygems.org"

ruby "2.1.3"

gem "autoprefixer-rails"
gem "coffee-rails", "~> 4.0.0"
gem "figaro", "~> 1.0.0"
gem "redcarpet", github: "vmg/redcarpet"
gem "coderay"
gem "haml-rails"
gem "high_voltage"
gem "jbuilder", "~> 2.0"
gem "jquery-rails"
gem "pg"
gem "rails", "4.1.6"
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

