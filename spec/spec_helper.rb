require 'rubygems'
require 'capybara'

# All our specs should require 'spec_helper' (this file)

# If RACK_ENV isn't set, set it to 'test'.  Sinatra defaults to development,
# so we have to override that unless we want to set RACK_ENV=test from the
# command line when we run rake spec.  That's tedious, so do it here.


#this line overrides enviornment default (development) with test
# when tests run, we will always be in test

# HOWEVER - test do not work with integration tests on controller
ENV['RACK_ENV'] ||= 'development'

# To create test database:
# in terminal, prefix rake db commands with RACK_ENV=test
# ex:
# RACK_ENV=test rake db:create
# RACK_ENV=test rake db:migrate
# RACK_ENV=test rake db:seed

require File.expand_path("../../config/environment", __FILE__)

Capybara.app = Sinatra::Application

RSpec.configure do |config|
  config.include Capybara::DSL
end

