require_relative "config/environment.rb"
require  "sinatra/activerecord/rake"

require_all "app/models"

def reload!
  load "config/environment.rb"
end
task :console do
  Pry.start
end
