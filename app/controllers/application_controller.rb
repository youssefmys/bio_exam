require "rack-flash"
require "pry"

class ApplicationController < Sinatra::Base

  use Rack::Flash


  configure do
    enable :sessions
    set :views, Proc.new {File.join(root, "../views")}
    set :public_folder, Proc.new {File.join(root, "../../public")}
    set :session_secret, "secrete"
  end

  get "/" do
    if loggedIn
      redirect "/users/#{currentUser.slug}"
    end
    erb :index
  end

  get "/exams" do

  end

  get  '/create_exam' do
    if loggedIn
      if session[:user_type] == 'teacher'
        erb :"exams/new"
      end
    else
      redirect '/users/login'
    end
  end

  get '/create_question' do
    if loggedIn
      if session[:user_type] == "teacher"
        @exam = Exam.find_by(:id => params[:exam_id])
        erb :"questions/new"
      end
    else
      redirect "/users/login"
    end
  end

  post '/questions' do
    question = Question.create(params[:question])
    params[:answers].each do |answer|
      answer = Answer.create(answer)
      question.answers << answer
    end

    exam = Exam.find_by(:id => params[:exam_id])

    question.exams << exam
    question.save
    redirect "/exams/#{exam.id}"
  end

  get '/exams/:id' do
    @exam = Exam.find_by(:id => params[:id])
    erb :"exams/show"
  end

  post '/exams' do
    exam = Exam.create(params[:exam])
    currentUser.exams << exam
    redirect "/exams/#{exam.id}"
  end

  helpers do

    def loggedIn
      !!session[:id]
    end

    def currentUser
      if teacher = Teacher.find_by(:id => session[:id])
        return teacher
      elsif student = Student.find_by(:id => session[:id])
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
        end
      end
      return false
    end

    def find_by_slug(slug_name)
      [Teacher, Student].each do |type|
        if user = type.find_by_slug(slug_name)
          return user
        else
          return false
        end
       end
    end

  end

end
