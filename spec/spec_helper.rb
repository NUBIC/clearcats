# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'


# Factory Girl was not autoloading factories hence the call to Factory.find_definitions
# cf. http://stackoverflow.com/questions/1160004/setup-factory-girl-with-testunit-and-shoulda
require 'factory_girl'
Factory.find_definitions

# Paperclip matchers
require 'paperclip/matchers'

require 'surveyor'
require 'shoulda'

module TestLogins
  def user_login
    Bcsec.authority.valid_credentials?(:user, 'cc_user', 'cc_user')
  end

  def admin_login
    Bcsec.authority.valid_credentials?(:user, 'cc_admin', 'cc_admin')
  end
  
  def faculty_login
    Bcsec.authority.valid_credentials?(:user, 'faculty', 'faculty')    
  end

  def login(as)
    controller.request.env['bcsec'] = Bcsec::Rack::Facade.new(Bcsec.configuration, as)
  end
end


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  
  config.include TestLogins
  config.include Paperclip::Shoulda::Matchers
end

def will_paginate_collection(collection, page = 1, per_page = 10)
  return WillPaginate::Collection.create(page, per_page) do |pager|
    pager.replace(collection)
    unless pager.total_entries
      pager.total_entries = collection.size
    end
  end
end

class Bcsec::Rack::Facade
  def permit!(*groups)
    true
  end
end
