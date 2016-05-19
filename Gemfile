source 'https://rubygems.org'

gem "mongoid", git: 'git://github.com/mongoid/mongoid.git'
gem 'rails', '4.2.4'
gem 'jbuilder', '~> 2.0'
gem 'bcrypt', '~> 3.1.7'
gem 'responders', '~> 2.0'
gem 'active_model_secure_token'
gem 'rack-cors', :require => 'rack/cors'

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'spring-commands-rspec'
  gem 'guard-rspec'
  gem 'rb-fsevent' if `uname` =~ /Darwin/
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'quiet_assets'
end

group :test do
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers', require: false
  gem 'database_cleaner'
  gem 'faker'
end
