class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :question
      t.string :body
      t.boolean :right
      t.timestamps null: false
    end
  end
end
