class CreateTeacherExams < ActiveRecord::Migration[5.1]
  def change
    create_table :teacher_exams do |t|
      t.integer :teacher_id
      t.integer :exam_id 
    end
  end
end
