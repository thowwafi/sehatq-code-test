Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'products#index'
  resources :products
  resources :orders do
    member do
      get :purchase
      get :cancel_purchase
    end
  end

  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
  end
end
