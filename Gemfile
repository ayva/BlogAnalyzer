source 'https://rubygems.org'

ruby '2.2.2'

gem 'delayed_job_active_record'
gem 'delayed_job_recurring'
gem 'mechanize'
gem 'git-hooks'

gem 'bower'

gem 'angular-ui-bootstrap-rails'

#check language
gem 'detect_language'

gem 'modernizr-rails'

#Work with API
gem 'httparty'
gem 'oauth'

# Angular
gem 'angularjs-rails'
gem 'angular_rails_csrf'

# Bootstrap
gem "twitter-bootstrap-rails"

#Twitter and Facebook authorization
gem 'omniauth-twitter'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use postgres as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem "figaro"

# Use jquery as the JavaScript library
gem 'jquery-rails'


# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug'
  gem 'pry'
  gem 'pry-byebug'

  gem "letter_opener"

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'spring'

  gem 'capybara'
  gem 'guard-rspec', require: false
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.0'

  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'better_errors'
  gem 'binding_of_caller'

end

group :production do
  gem 'rails_12factor'
  gem 'puma'
end

