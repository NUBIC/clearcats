source "http://rubygems.org"
source 'http://download.bioinformatics.northwestern.edu/gems'
source 'http://gems.github.com'

gem "rails", "3.0.6"

gem "activerecord-oracle_enhanced-adapter", "~> 1.3"
gem "bcdatabase", "~> 1.0.5"
gem "bcsec", "~> 2.1.1"
gem "bcsec-rails", ">= 3.0"
gem "bundler", "~> 1.0.0"

gem "chronic"

gem 'exception_notification', :require => 'exception_notifier'

gem "fastercsv"
gem "haml", "~> 3.0.18"
gem "meta_search"
gem "nokogiri"
gem "paper_trail", "~> 2.0"
gem "paperclip"
gem "pg"

gem "ruby-oci8"
gem "state_machine"
gem "surveyor"
gem "will_paginate", "~> 3.0.pre2"
gem "zippy"

group :development do
  gem 'capistrano'
    
  # metric_fu
  gem "metric_fu", "~> 2.1.1"
  gem "reek"
  gem "roodi"
  gem "ruby-prof"
  gem 'turbulence'
end

group :development, :test, :ci do
  # rspec
  gem "rspec-rails", "~> 2.4"
end

group :test, :ci do

  # autotest
  # gem "autotest"
  # gem "autotest-rails"
  # gem "autotest-growl"
  # gem 'ZenTest', "~> 4.5.0"
  gem 'test_notifier'
  
  # factory_girl
  gem "factory_girl"
  
  # shoulda
  gem "shoulda"
  
  # cucumber
  gem "builder"
  gem "capybara"
  gem "cucumber"
  gem "cucumber-rails"
  gem "database_cleaner"
  gem "gherkin"
  gem "shoulda"
  gem 'rcov'
  gem 'pickle'
  gem 'fakeweb'
  gem "treetop"
  gem "launchy", '~> 0.4'
  gem "term-ansicolor"
  gem "trollop"
  
  gem "ci_reporter"
  
  gem "timecop"
  
  gem "test-unit", "~> 2.2"
end

#source 'http://rubygems.org'
#
#gem 'rails', '3.0.6'
#
## Bundle edge Rails instead:
## gem 'rails', :git => 'git://github.com/rails/rails.git'
#
#gem 'sqlite3'
#
## Use unicorn as the web server
## gem 'unicorn'
#
## Deploy with Capistrano
## gem 'capistrano'
#
## To use debugger (ruby-debug for Ruby 1.8.7#, ruby-debug19 for Ruby 1.9.2#)
## gem 'ruby-debug'
## gem 'ruby-debug19', :require => 'ruby-debug'
#
## Bundle the extra gems:
## gem 'bj'
## gem 'nokogiri'
## gem 'sqlite3-ruby', :require => 'sqlite3'
## gem 'aws-s3', :require => 'aws/s3'
#
## Bundle gems for the local environment. Make sure to
## put test-only gems in this group so their generators
## and rake tasks are available in development mode:
## group :development, :test do
##   gem 'webrat'
## end
