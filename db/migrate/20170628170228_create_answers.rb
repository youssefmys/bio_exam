class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :content
      t.boolean :right_answer, :default => false 
    end
  end
end
