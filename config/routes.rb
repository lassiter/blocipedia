# require 'rails_helper'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    omniauthable: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    unlocks: 'users/unlocks'
  }
  root to: "home#index"
  
  resources :wikis
  resources :users
  post 'users/downgrade/:id' => 'users#downgrade', as: :downgrade
  resources :charges, only: [:new, :create]
end
