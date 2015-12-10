require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { FactoryGirl.create(:question) }

  describe "GET #index" do
    before { get :index }

    it 'loads all questions' do
      questions = FactoryGirl.create_list(:question, 3)
      expect(assigns(:questions)).to eq questions
    end

    it 'renders index template' do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before { get :show, id: question }

    it 'loads question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show template' do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before { get :new }

    it 'assigns new Question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders show template' do
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    before { get :edit, id: question }

    it 'assigns new Question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit template' do
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    context 'valid' do
      it 'saves new question in DB' do
        expect { post :create,
                      question: FactoryGirl.attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'redirects to show' do
        post :create,
             question: FactoryGirl.attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'invalid' do
      it 'does not save new question in DB' do
        expect { post :create,
                      question: FactoryGirl.attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 'renders show template' do
        post :create,
             question: FactoryGirl.attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    context 'valid' do
      before { patch :update, id: question, question: { title: 'new title', body: 'new body' } }
      it 'changes question' do
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to show' do
        expect(response).to redirect_to question
      end
    end

    context 'invalid' do
      before { patch :update, id: question, question: { title: nil, body: nil } }

      it 'does not change question attributes' do
        question.reload
        expect(question.title).to eq "My question"
        expect(question.body).to eq "question body"
      end

      it 'render edit template' do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before { question }

    it 'deletes question from DB' do
      expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end
end
