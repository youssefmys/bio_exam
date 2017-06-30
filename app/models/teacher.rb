class Teacher < ActiveRecord::Base
  validates :username, :email, :password, :presence => true

  has_many :studnets, :through => :teacher_students
  has_many :exams , :through => :teacher_exams

  has_secure_password
end
