source 'https://rubygems.org'
ruby '2.2.2'
gem 'rails', '4.2.5'
gem 'rubycas-client', :git => 'git://github.com/rubycas/rubycas-client.git'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'haml'

group :development, :test do
  gem 'byebug'
  gem 'jasmine-rails'
  gem 'sqlite3'
end

group :test do
  gem 'rspec-rails'
  gem 'simplecov', :require => false
  gem 'coveralls', :require => false
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels', :require => false
  gem 'database_cleaner'
  gem 'autotest-rails'
  gem 'factory_girl_rails'
  gem 'metric_fu'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'autotest'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
