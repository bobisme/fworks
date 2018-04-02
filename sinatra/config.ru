require 'bundler/setup'
require_relative 'app/main'

use Loga::Rack::RequestId
use Loga::Rack::Logger

run App
