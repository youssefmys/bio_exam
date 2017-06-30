class UserController < ApplicationController

  use Rack::Flash

  get "/users/:slug" do
      erb :"users/show"
  end

  get "/users/login" do
    erb :"users/login"
  end

  post "/users/login" do

    username = params[:user][:username]
    pass = params[:user][:password]

    if empty_field?(username) || empty_field?(pass)
      erb :"users/login"
    elsif find_and_authenticate(username, pass)
      redirect "/exams"
    else
      erb :"users/login"
    end

  end

  get "/users/logout" do
    sessions.clear
  end

  get "/users/signup" do
    if loggedIn
      redirect "/users/#{currentUser.slug}"
    else
      erb :"users/signup"
    end
  end

  post "/users/signup" do
    username = params[:user][:username]
    pass = params[:user][:password]
    email = params[:user][:email]

    if empty_field?(username) || empty_field?(pass) || empty_field?(email)
      erb :"/users/signup"
    elsif user_exists?(username)
      erb :"/users/signup"
    else
      params[:user_type] == "teacher"? Teacher.create(params[:user]) : Student.create(params[:user])
      redirect "/users/#{currentUser.slug}"
    end

  end

end
