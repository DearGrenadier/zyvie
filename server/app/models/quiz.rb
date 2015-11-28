class Quiz < ActiveRecord::Base
  has_and_belongs_to_many :questions

  class << self
    Question.subclasses.each do |subclass|
      method = subclass.underscore.split(/_/).first + "_quiz"
      define_method method do
        questions = []
        while questions.size != 5 do
          question = subclass.constantize.where.not(id: questions.map(&:id))
                     .order("random()").limit(1).first
          question.answers.order('random()')
          questions << question
        end
      end
    end
  end

  class << self
    def generate_general_quiz
      questions = []
      while questions.size != 6 do
        question = Question.subclasses.sample.constantize.where.not(id: questions.map(&:id)).order("random()").limit(1).first
        next unless question
        question.answers.order('random()')
        questions << question
      end
      questions
    end
  end
end
