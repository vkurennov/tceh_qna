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

  describe '#set_best' do
    let!(:question) { create(:question) }
    let!(:other_answer) { create(:answer, best: true, question: question) }
    let(:answer) { create(:answer, best: false, question: question) }


    it 'sets best flag to true' do
      answer.set_best
      expect(answer).to be_best
    end

    it 'change other answers best flag to false' do
      answer.set_best
      expect(other_answer.reload).to_not be_best
    end
  end
end
