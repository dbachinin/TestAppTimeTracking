source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'devise'
gem 'whenever'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.5'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'mongoid', '< 7.0.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

gem 'bootstrap'

gem 'rails-ujs'

gem 'jquery-rails'

gem 'nested_form'

gem 'simple_form'

gem 'rmagick'

gem "font-awesome-rails"

gem 'bootstrap-datepicker-rails', :require => 'bootstrap-datepicker-rails', :git => 'git://github.com/Nerian/bootstrap-datepicker-rails.git'

gem 'tinymce-rails'

gem 'popper_js'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem "rspec-rails"
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'forgery'
  gem "database_cleaner"
  gem "mongoid-rspec"
  gem "email_spec"
  gem "launchy"  
  gem "shoulda"
  gem "poltergeist"
  gem 'simplecov'
  gem 'guard-rspec'

  gem 'sextant'
  gem 'pry-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
