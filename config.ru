require_relative "config/environment.rb"

use Rack::MethodOverride
use UserController 
run ApplicationController
