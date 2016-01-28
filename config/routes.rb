Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks'}

  resources :questions do
    post :vote_up, on: :member
    resources :answers
  end

  namespace :api do
    namespace :v1 do
      resources :profiles do
        get :me, on: :collection
      end
      resources :questions
    end
  end

  root to: 'questions#index'
end
