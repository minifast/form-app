Rails.application.routes.draw do
  devise_for :users
  get 'user_forms/new'
  resources :user_forms

  root to: 'user_forms#new'
end
