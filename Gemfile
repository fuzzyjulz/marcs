ruby "2.5.1"
source 'https://rubygems.org'

gem 'rails', '~> 5'
gem 'pg', '0.21.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks'
gem 'devise'
gem 'simple_form'
gem 'mini_portile2'
gem 'cancan'

gem 'bootstrap-sass'
gem 'koala'                         #Facebook API for newsfeed
gem 'google_drive'                  #Connector to google drive and spreadsheets
gem "paperclip", "~> 6.1.0"
gem 'sendgrid-rails', '>= 0.10.0'
gem 'icalendar'
#gem "icalendar-recurrence"
gem "icalendar-recurrence", git: 'git://github.com/fuzzyjulz/icalendar-recurrence.git'
#gem "icalendar-recurrence", path: '/Users/julz/Documents/workspace/icalendar-recurrence'

gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'coffee-script-source', '1.8.0'
gem 'haml'
gem 'jquery-rails'

gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :docs
gem 'gabba-gmp'

group :development, :test do
  gem 'byebug'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'colorize'
  gem 'webmock'
end
group :test do
  gem 'simplecov'
  gem 'codeclimate-test-reporter'
end
group :development do
  gem 'better_errors'
  gem 'pry'
  gem 'web-console', '~> 2.0'
end
group :production do
  gem 'rails_12factor'
  gem 'aws-sdk', '~> 2.3'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
