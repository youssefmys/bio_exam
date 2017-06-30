class UserController < ApplicationController

  use Rack::Flash
  get "/users/login" do
    erb :"users/login"
  end

  post "/users/login" do
    if user = Teacher.find_by(:username => params[:username])
      user.authenticate(params[:password])
      sessions[:id] = user.id
      sessions[:user_type] = "teacher"
      redirect "/exams"
    elsif user = Student.find_by(:username => params[:username])
      sessions[:id] = user.id
      sessions[:user_type] = "student"
      redirect "/exams"
    else
      flash[:message] = "Wrong username or password!"
      erb :"/users/login"
    end
  end

  get "/users/logout" do
    sessions.clear
  end

  get "/users/signup" do
    if loggedIn
      redirect "/tests"
    else
      erb :"users/signup"
    end
  end

  post "/users/signup" do
    if user = Teacher.find_by(:username => params[:username])
      flash[:message] = "username already exists!"
      redirect "/users/signup"
    end
    params[:user_type] == "teacher"? Teacher.create(params[:user]) : User.create(params[:user])
  end


end
