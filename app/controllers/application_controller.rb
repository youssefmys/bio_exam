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

    def find_and_authenticate(username, pass)
      [Teacher, Student].each do |type|
        if user = type.find_by(username: username)
           return authenticate(user, pass)
        else
            flash[:message] = "Wrong username or password"
            return false
        end
      end
    end

    def authenticate(user, password)
      if user_obj = user.authenticate(password)
        user_obj
      else
        flash[:message] = "Wrong password!"
        return false
      end
    end

    def empty_field?(field)
      if field.match(/^$/)
        flash[:message] = "Please fill in required fields"
      end
    end

    def user_exists?(username)
      [Teacher, Student].each do |type|
        if type.find_by(username: username)
          flash[:message] = "Username already exists!"
          return true
        else
          return false
        end
      end
    end

  end

end
