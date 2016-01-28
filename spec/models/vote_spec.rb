require 'rails_helper'

RSpec.describe Vote, type: :model do

  it { should belong_to :user }
  it { should belong_to :votable }

  # let(:mock) { double(Question, id: 5, title: '3') }

  describe 'reputation' do
    before do
      # allow(Question).to recieve(:new).and_return(mock)
      allow(Reputation).to receive(:calculate).and_return(5)
    end

    it 'calculates reputation after create' do
      expect(Reputation).to receive(:calculate).with(subject)
      subject.save!
    end

    it 'does not calculate reputation after update' do
      subject.save!
      expect(Reputation).to_not receive(:calculate)
      subject.update!(value: 1)
    end
  end
end
