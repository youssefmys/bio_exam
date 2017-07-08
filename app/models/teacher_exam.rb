class TeacherExam < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :exam
end
