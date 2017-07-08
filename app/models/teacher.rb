class Teacher < ActiveRecord::Base

  include Sluggable::InstanceMethods
  extend Sluggable::ClassMethods

  has_many :teacher_exams
  validates :username, :email, :password, :presence => true

  has_many :studnets, :through => :teacher_students
  has_many :exams , :through => :teacher_exams

  has_secure_password
end
