module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  # class_methods do
  #
  # end

  def vote_up(user)
    make_vote(user, 1)
  end

  def vote_down(user)
    make_vote(user, -1)
  end

  def votes_sum
    votes.sum(:value)
  end

  private

  def make_vote(user, value)
    votes.create!(user: user, value: value)
  end
end