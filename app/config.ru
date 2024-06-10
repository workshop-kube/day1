require 'rack'

require_relative "app"

use Rack::CommonLogger

run App.new