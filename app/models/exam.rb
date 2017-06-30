class Exam < ActiveRecord::Base
  has_many :teachers, :through => :teacher_exams
  has_many :exams, :through => :question_exams
  has_many :students , :through => :student_exams 
end
