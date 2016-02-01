require 'rails_helper'

RSpec.describe DailyDigestJob, type: :job do
  let(:users) { create_list(:user, 5) }

  it 'sends daily digest to all users' do
    users.each do |user|
      expect(DailyDigest).to receive(:digest).with(user).and_call_original
    end
    DailyDigestJob.perform_now
  end
end
