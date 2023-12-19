source "https://rubygems.org"

ruby "3.2.2"

gem "bootsnap", require: false
gem "devise", "~> 4.9"
gem "good_job", "~> 3.21"
gem "initials", "~> 0.4.3"
gem "pagy", "~> 6.2"
gem "pg", "~> 1.1"
# Pluck to Struct?
gem "pry-rails", "~> 0.3.9"
gem "pry-remote", "~> 0.1.8"
gem "puma", ">= 5.0"
gem "rails", "~> 7.1.2"
gem "redis", ">= 4.0.1"
gem "rubydns", "~> 2.0"
gem "sassc-rails", "~> 2.1"
gem "stimulus-rails"
gem "turbo-rails"
gem "vite_rails", "~> 3.0"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows]
  gem "minitest-focus"
end

group :development do
  gem "rack-mini-profiler"
  gem "rubocop", "~> 1.57"
  gem "solargraph", "~> 0.49.0"
  gem "syntax_tree", "~> 6.2"
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webmock"
end
