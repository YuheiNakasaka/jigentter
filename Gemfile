source 'https://rubygems.org'

gem 'rails', '4.2.2'
gem 'mysql2', '~> 0.3.20'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'devise'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'dotenv-rails'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'resque', :require => 'resque/server'
gem 'daemon-spawn', :require => 'daemon_spawn'
gem 'twitter'
gem 'whenever', :require => false

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'better_errors'
  gem 'guard-livereload'
  gem 'spork', '~> 1.0.0rc3'
  gem 'guard-spork'
  gem 'guard-rspec'
end

group :production do
  gem 'therubyracer'
  gem 'newrelic_rpm'
  gem 'unicorn'
  gem 'unicorn-worker-killer'
end