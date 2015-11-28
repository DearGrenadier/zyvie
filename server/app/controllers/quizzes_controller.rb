class QuizzesController < ApplicationController
  respond_to :json

  Question.subclasses.each do |subclass|
    method = subclass.underscore.split(/_/).first + "_quiz"
    define_method method do
      @questions = Quiz.send(method)
      @quiz = Quiz.new
      @quiz.questions = @questions
      if @quiz.save
        respond_with @quiz
      end
    end
  end

  def general
    @questions = Quiz.generate_general_quiz
    @quiz = Quiz.new
    @quiz.questions = @questions
    if @quiz.save
      respond_with @quiz
    end
  end

  def result
    json = JSON.parse(request.body.read)
    json.deep_symbolize_keys!
    @quiz = Quiz.find(json[:id])
    json[:answers].each do |ans|
      @question = Question.find(ans[:id])
      if ans[:ans]
        @question.increment!(:right_answered)
      else
        @question.increment!(:wrong_answered)
      end
    end
    @quiz.update(quiz_results: json[:answers])
    render nothing: true, status: 200
  end
end
