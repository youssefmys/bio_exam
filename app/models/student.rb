class Student < ActiveRecord::Base

  include Sluggable::InstanceMethods
  extend Sluggable::ClassMethods

  has_many :student_exams
  validates :username, :email, :password, :presence => true

  has_many :teachers , :through => :teacher_students
  has_many :exams , :through => :student_exams

  has_secure_password
end
