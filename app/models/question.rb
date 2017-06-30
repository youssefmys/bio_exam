class Question < ActiveRecord::Base
  has_many :exams, :through => :question_exams 
end
