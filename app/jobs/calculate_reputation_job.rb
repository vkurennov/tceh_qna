class CalculateReputationJob < ActiveJob::Base
  queue_as :default

  def perform(object)
    Reputation.calculate(object)
  end
end
