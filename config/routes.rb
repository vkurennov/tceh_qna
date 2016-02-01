Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks'}

  concern :votable do
    post :vote_up, on: :member
    post :vote_down, on: :member
  end

  concern :comments do
    resources :comments, shallow: true
  end

  resources :questions, concerns: [:votable, :comments] do
    resources :answers, concerns: [:votable, :comments], shallow: true
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
