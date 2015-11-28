class Question < ActiveRecord::Base
  DESCENDANTS = ['HistoricalQuestion']
  validates :type, presence: true
  has_many :answers, dependent: :destroy
  has_and_belongs_to_many :quizzes

end
