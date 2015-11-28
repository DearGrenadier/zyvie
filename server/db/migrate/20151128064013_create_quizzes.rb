class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|

      t.timestamps null: false
    end

    create_table :quizzes_questions do |t|
      t.belongs_to :quiz, index: true
      t.belongs_to :question, index: true
    end
  end
end
