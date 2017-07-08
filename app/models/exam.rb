
class Exam < ActiveRecord::Base
  has_many :question_exams
  has_many :teachers, :through => :teacher_exams
  has_many :questions, :through => :question_exams
  has_many :students , :through => :student_exams
end
