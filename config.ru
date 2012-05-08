# This file is used by Rack-based servers to start the application.

require 'newrelic_rpm'
require 'new_relic/collection_helper'
require 'new_relic/rack_app'
use NewRelic::Rack::DeveloperMode

require ::File.expand_path('../config/environment',  __FILE__)
run V01::Application

