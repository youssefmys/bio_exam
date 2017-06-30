class CreateQuestionExams < ActiveRecord::Migration[5.1]
  def change
    create_table :question_exams do |t|
      t.integer :question_id
      t.integer :exam_id 
    end
  end
end
