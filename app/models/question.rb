class Question < ActiveRecord::Base
  include Votable
  include Attachable

  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, :user_id, :body, presence: true
end
