source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

# Rails Core Gems
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem 'bcrypt', '~> 3.1.7'
gem 'cssbundling-rails'
gem 'image_processing', '~> 1.2'
gem 'jsbundling-rails'
# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'
gem 'pg', '~> 1.1'
gem 'pg_query'
gem 'propshaft'
gem 'puma', '~> 5.0'
gem 'stimulus-rails'
gem 'turbo-rails'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  # store env variables in a .env file during dev
  gem 'dotenv-rails'
  # testing
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'webdrivers'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # dev tools
  gem 'annotate'
  gem 'brakeman'
  gem 'bullet'
  gem 'database_consistency', '>= 1.1.15'
  gem 'prosopite'
  gem 'rails-erd'
  gem 'rubocop', require: false
  gem 'rubocop-i18n', require: false
  gem 'rubocop-md', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', '>= 2.11.1', require: false
end

group :test do
  gem 'simplecov'
end

# Application gems: Data
gem 'i18n-tasks'
gem 'rails-i18n'

gem 'countries'
gem 'country-select'
gem 'i18n-country-translations'

# Application gems: Authentication and Security
gem 'devise'
gem 'devise-i18n'

# Application gems: Visuals
