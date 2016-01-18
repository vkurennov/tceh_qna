Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks'}

  resources :questions do
    resources :answers
  end

  root to: 'questions#index'
end
