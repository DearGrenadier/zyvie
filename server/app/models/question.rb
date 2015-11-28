class Question < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  validates :type, presence: true
  has_many :answers, dependent: :destroy
  has_and_belongs_to_many :quizzes


  class << self
    def subclasses
      Rails.application.eager_load!
      descendants.map(&:to_s)
    end
  end

end
