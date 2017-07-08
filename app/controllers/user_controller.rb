class UserController < ApplicationController

  enable :sessions

  get "/users/login" do
    if loggedIn
      redirect "/users/#{currentUser.slug}"
    else
      erb :"users/login"
    end

  end

  post "/users/login" do
    if params[:user].values.any?{|v| empty_field?(v)}
      erb :"users/login"
    elsif user = find_and_authenticate(params[:user][:username], params[:user][:password])
      session[:id] = user.id
      session[:user_type] = user.class.to_s.downcase
      redirect "/users/#{currentUser.slug}"
    else
      erb :"users/login"
    end
  end

  get "/users/logout" do
    session.clear
  end

  get "/users/signup" do
    if loggedIn
      redirect "/users/#{currentUser.slug}"
    else
      erb :"users/signup"
    end
  end

  post "/users/signup" do
    if params[:user].values.any?{|v| empty_field?(v)}
      erb :"/users/signup"
    elsif user_exists?(username = params[:user][:username])
      erb :"/users/signup"
    else
      params[:user_type] == "teacher" ? user = Teacher.create(params[:user]) : user = Student.create(params[:user])
      session[:id] = user.id
      session[:user_type] = user.class.to_s.downcase
      redirect "/users/#{user.slug}"
    end
  end

  get "/users/:slug" do
      if @user = find_by_slug(params[:slug])
        erb :"users/show"
      end
  end

end
