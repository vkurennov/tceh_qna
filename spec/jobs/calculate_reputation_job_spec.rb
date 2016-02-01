require 'rails_helper'

RSpec.describe CalculateReputationJob, type: :job do
  let(:answer) { create(:answer) }

  it 'calculates reputation' do
    expect(Reputation).to receive(:calculate).with(answer)
    CalculateReputationJob.perform_now(answer)
  end
end
