class Student < ActiveRecord::Base
  validates :username, :email, :password, :presence => true

  has_many :teachers , :through => :teacher_students
  has_many :exams , :through => :student_exams

  has_secure_password
end
