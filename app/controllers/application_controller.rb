require "rack-flash"
require "pry"

class ApplicationController < Sinatra::Base

  use Rack::Flash

  configure do
    set :sessions, true
    set :views, Proc.new {File.join(root, "../views")}
    set :public_folder, Proc.new {File.join(root, "../../public")}
    set :session_secrete, "secrete"
  end

  get "/" do
    erb :index
  end

  get "/exams" do 

  end
  helpers do

    def loggedIn
      !!session[:id]
    end

    def currentUser
      if teacher = Teacher.find_by(:id => session[:id])
        return teacher
      elsif student = User.find_by(:id => session[:id])
        return student
      else
        return nil
      end
    end

  end

end
