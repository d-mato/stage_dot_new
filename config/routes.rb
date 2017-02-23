Rails.application.routes.draw do
  resource :resume, only: [:show, :edit, :update]

  resources :companies, shallow: true do
    get :archives, on: :collection
    match :archive, via: [:post, :delete]
    resources :interviews, except: [:index]
  end

  resources :interviews, only: [:index]

  resource :contact, only: [:show, :create]

  match 'settings/account', via: [:get, :put]

  authenticated :user do
    root 'home#index'
  end

  unauthenticated :user do
    root 'static_pages#index'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
