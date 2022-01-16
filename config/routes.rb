Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resource :contact, only: [:show, :create]

  authenticated :user do
    root 'home#index'
    resources :companies, shallow: true do
      get :archives, on: :collection
      match :archive, via: [:post, :delete]
      resources :interviews, except: [:index]
    end
    resources :interviews, only: [:index]
    resource :resume, only: [:show, :edit, :update]
    match 'settings/account', via: [:get, :put]
    resources :users, only: [:index, :show] do
      resources :companies, only: [:show], controller: 'users/companies'
      resources :interviews, only: [:show], controller: 'users/interviews'
    end
    resources :feeds, only: [:index]
  end

  unauthenticated :user do
    root 'static_pages#index'
  end
end
