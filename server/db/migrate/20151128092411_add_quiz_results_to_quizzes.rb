class AddQuizResultsToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :quiz_results, :json
  end
end
