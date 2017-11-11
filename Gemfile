source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bcrypt", "~> 3.1.7"
gem "bootstrap-sass"
gem "coffee-rails", "~> 4.2"
gem "hamlit-rails"
gem "kaminari"
gem "kaminari-i18n"
gem "missing_validators"
gem "mysql2"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.2"
gem "rails-i18n"
gem "sass-rails", "~> 5.0"
gem "seed-fu"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "factory_girl_rails"
  gem "faker"
  gem "pry-byebug"
  gem "pry-doc"
  gem "pry-rails"
  gem "pry-stack_explorer"
  gem "rspec-rails"
end

group :development do
  gem "annotate"
  gem "onkcop", require: false
  gem "rails-erd", require: false
  gem "rubocop", require: false
  gem "spring"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
end
