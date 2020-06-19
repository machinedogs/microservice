# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.
require "rack-timeout"
require_relative 'config/environment'

run Rails.application

# Call as early as possible so rack-timeout runs before all other middleware.
# Setting service_timeout or `RACK_TIMEOUT_SERVICE_TIMEOUT` environment
# variable is recommended. If omitted, defaults to 15 seconds.
use Rack::Timeout, service_timeout: 60, wait_timeout: 60, wait_overtime: 60, service_past_wait: false, term_on_timeout:   false 
