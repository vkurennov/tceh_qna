class Answer < ActiveRecord::Base
  include Votable
  include Attachable

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy

  validates :question_id, :body, presence: true

  accepts_nested_attributes_for :attachments

  after_create :calculate_reputation

  private

  def calculate_reputation
    CalculateReputationJob.perform_later(self)
  end
end
