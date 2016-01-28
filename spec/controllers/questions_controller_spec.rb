require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
let!(:question) { create(:question) }
let!(:user) { create(:user) }


describe "GET #index" do
  let!(:questions) { create_list(:question, 3) }
  before { get :index }

  it 'loads all questions' do
    # expect(controller.instance_variable_get(:@questions)).to eq questions
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

  before do
    login(user)
    get :new
  end

  it 'assigns new Question' do
    expect(assigns(:question)).to be_a_new(Question)
  end

  it 'renders show template' do
    expect(response).to render_template :new
  end
end

describe "GET #edit" do
  before do
    login(user)
    get :edit, id: question
  end

  it 'assigns new Question' do
    expect(assigns(:question)).to eq question
  end

  it 'renders edit template' do
    expect(response).to render_template :edit
  end
end

describe "POST #create" do
  before { login(user) }

  context 'valid' do
    it 'saves new question in DB' do
      expect { post :create,
                    question: attributes_for(:question) }.to change(Question, :count).by(1)
    end

    it 'redirects to show' do
      post :create,
           question: attributes_for(:question)
      expect(response).to redirect_to question_path(assigns(:question))
    end
  end

  context 'invalid' do
    it 'does not save new question in DB' do
      expect { post :create,
                    question: attributes_for(:invalid_question) }.to_not change(Question, :count)
    end

    it 'renders show template' do
      post :create,
           question: attributes_for(:invalid_question)
      expect(response).to render_template :new
    end
  end
end

describe "PATCH #update" do
  before { login(user) }

  context 'valid' do
    before { patch :update, id: question, question: {title: 'new title', body: 'new body' }}
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
    before { patch :update, id: question, question: {title: nil, body: nil }}

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
  before do
    login(user)
  end

  context "author deletes his own question" do
    let!(:question) { create(:question, user: user) }

    it 'deletes question from DB' do
      expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end

  context 'non-author can not delete question' do
    before { question }

    it 'does not delete question from DB' do
      expect { delete :destroy, id: question }.to_not change(Question, :count)
    end
    end
  end

  describe "POST /vote_up" do
    before { login(user) }

    it 'calls Question#vote_up method' do
      question = create(:question)
      allow(Question).to receive(:find).and_return(question)
      expect(question).to receive(:vote_up).with(user)
      post :vote_up, id: question
    end
  end
end


