class QuestionsController < ApplicationController
  def create
    binding.pry
  end

  def statistic
    @statistic = {}
    Question.subclasses.each do |subclass|
      res = { right: 0, wrong: 0 }
      subclass.constantize.select(:right_answered, :wrong_answered) do |qsn|
        res[:right] += qsn.right_answered
        res[:wrong] += qsn.wrong_answered
      end
      @statistic[subclass.underscore.split(/_/).first.to_sym] = res
    end
    render status: 200, json: @statistic.to_json
  end
end
