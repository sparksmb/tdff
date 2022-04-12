source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem "rails", "~> 7.0.2", ">= 7.0.2.3" # The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails" # Use postgresql as the database for Active Record
gem "pg", "~> 1.1" # Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0" # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails" # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails" # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails" # Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder" # Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0" # Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ] # Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false # Use Sass to process CSS

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
  # gem "spring"
end

