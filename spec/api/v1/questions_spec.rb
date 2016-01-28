require 'rails_helper'

RSpec.describe "Questions API" do
  describe "GET /index" do
    it_behaves_like "API Authenticable" do
      # let(:do_request) { get '/api/v1/questions', format: :json }

      let(:method) { :get }
      let(:api_path) { '/api/v1/questions' }


      # def do_request(options = {})
      #   get '/api/v1/questions', { format: :json }.merge(options)
      # end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token)}
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let!(:answer) { create(:answer, question: question) }

      before { get '/api/v1/questions', format: :json, access_token: access_token.token }

      it 'returns 200 status' do
        expect(response).to be_success
      end

      it 'returns list of questions' do
        expect(response.body).to have_json_size(2).at_path('questions')
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr).to_json).at_path("questions/0/#{attr}")
        end
      end

      context 'answers' do
        it 'included in question' do
          expect(response.body).to have_json_size(1).at_path('questions/0/answers')
        end

        %w(id body created_at updated_at).each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr).to_json).at_path("questions/0/answers/0/#{attr}")
          end
        end
      end
    end
  end
end