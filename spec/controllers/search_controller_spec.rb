require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe "GET #search" do
    it "calls sphinx search" do
      expect(ThinkingSphinx).to receive(:search).with('test')
      get :search, q: 'test'
    end

    it 'render search template' do
      get :search, q: 'test'
      expect(response).to render_template :search
    end
  end

end
