Rails.application.routes.draw do
  get 'user_forms/new'
  resources :user_forms

  root to: 'user_forms#new'
end
