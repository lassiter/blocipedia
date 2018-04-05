# require 'rails_helper'

Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  
  resources :wikis

end
