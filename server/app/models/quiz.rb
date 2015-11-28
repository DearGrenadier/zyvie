class Quiz < ActiveRecord::Base
  QUESTIONS = ['HistoricalQuestion']
  has_and_belongs_to_many :questions

  class << self
    def generate_general_quiz
      questions = []
      10.times do
        question = QUESTIONS.sample.constantize.order("RANDOM()").limit(1)
        question.answers.shuffle!
        questions << question
      end
      questions
    end
  end
end
