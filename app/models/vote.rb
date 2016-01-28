class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  after_create :calculate_reputation

  private

  def calculate_reputation
    Reputation.calculate(self)
  end
end
