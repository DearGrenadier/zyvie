class QuizzesController < ApplicationController

  def general
    @quiz = Quiz.generate_general_quiz
    respond_with @quiz
  end
end
