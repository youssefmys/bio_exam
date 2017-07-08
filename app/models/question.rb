class Question < ActiveRecord::Base
  has_many :answers
  has_many :question_exams
  has_many :exams, :through => :question_exams
end
