require './sin'
require 'rack/contrib'

use Rack::PostBodyContentTypeParser

run Sin
