require 'rubygems'
require 'capybara'

# All our specs should require 'spec_helper' (this file)

# If RACK_ENV isn't set, set it to 'test'.  Sinatra defaults to development,
# so we have to override that unless we want to set RACK_ENV=test from the
# command line when we run rake spec.  That's tedious, so do it here.
ENV['RACK_ENV'] ||= 'development'

require File.expand_path("../../config/environment", __FILE__)

Capybara.app = Sinatra::Application

RSpec.configure do |config|
  config.include Capybara
end
