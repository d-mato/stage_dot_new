Rails.application.routes.draw do
  resources :companies, shallow: true do
    get :archives, on: :collection
    match :archive, via: [:post, :delete]
    resources :interviews, except: [:index]
  end
  resources :interviews, only: [:index]
  resource :resume, only: [:show, :edit, :update]
  match 'settings/account', via: [:get, :put]

  resource :contact, only: [:show, :create]

  resources :users, only: [:index, :show] do
    resources :companies, only: [:show], controller: 'users/companies'
    resources :interviews, only: [:show], controller: 'users/interviews'
  end

  authenticated :user do
    root 'home#index'
  end

  unauthenticated :user do
    root 'static_pages#index'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
