Rails.application.routes.draw do
  resources :companies, shallow: true do
    resources :interviews, except: [:index]
  end

  resources :interviews, only: [:index]

  resource :contact, only: [:show, :create]

  authenticated :user do
    root 'home#index'
  end

  unauthenticated :user do
    root 'static_pages#index'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
