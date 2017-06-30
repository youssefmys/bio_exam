SINATRA_ENV ||= "development"

require "bundler/setup"
Bundler.require

require_all "app/models"
require_all "app/controllers"
require "tux"
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3" ,
  :database => "db/#{SINATRA_ENV}.sqlite"
)
