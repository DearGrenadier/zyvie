class AddQuizResultsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :right_answered, :integer, default: 0
    add_column :questions, :wrong_answered, :integer, default: 0
  end
end
