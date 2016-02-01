require 'rails_helper'

describe Answer do
  it { should belong_to :question }
  it { should have_many(:attachments).dependent(:destroy) }

  it { should validate_presence_of :body }
  it { should validate_presence_of :question_id }

  it { should accept_nested_attributes_for :attachments }


  it_behaves_like "Votable" do
    subject { create(:answer) }
  end

  describe 'reputation' do
    subject { build(:answer) }

    it 'calculates reputation after create' do
      expect(CalculateReputationJob).to receive(:perform_later).with(subject)
      subject.save!
    end

    it 'does not calculate reputation after update' do
      subject.save!
      expect(CalculateReputationJob).to_not receive(:perform_later)
      subject.update!(body: "123")
    end
  end
end
